# frozen_string_literal: true

module Api
  module V1
    class DailyTasksController < ApplicationController
      # before_action :authenticate_employee!
      before_action :set_daily_task, only: %i[show update]
      skip_before_action :verify_authenticity_token

      def index
        @daily_task_data = current_employee.daily_tasks.order(created_at: :desc)
        render json: {
          data: serializer_data(@daily_task_data, serializer),
          message: ['daily task list '], status: 200, type: 'Success'
        }
      end

      def show
        @daily_task_data = current_employee.daily_tasks.find_by_id params[:id]
        render json: {
          data: serializer_data(@daily_task_data, serializer),
          message: ['show daily task  '], status: 200, type: 'Success'
        }
      end

      def create
        daily_task_data = DailyTask.new(params_daily_task)
        if daily_task_data.save
          render json: {
            data: serializer_data(daily_task_data, serializer),
            message: ['Successfully daily task create '], status: 200, type: 'Success'
          }
        else
          render json: @daily_task_data
        end
      end

      def update
        @daily_task_data = current_employee.daily_tasks.where('EXTRACT(DAY FROM created_at) = ?',
                                                              Date.current.day).first
        if @daily_task_data.present?
          @daily_task_data.update(params_daily_task)
          render json: {
            data: serializer_data(@daily_task_data, serializer),
            message: ['Successfully daily task  update'], status: 200, type: 'Success'
          }
        else
          render json: { message: ['daily tasks not update'] }, status: 304, type: 'failed'
        end
      end

      private

      def set_daily_task
        @daily_task_data = DailyTask.find_by_id params[:id]
        render json: { message: 'Not Found' }, status: 404 unless @daily_task_data.present?
      end

      def params_daily_task
        params.require(:daily_task).permit(:description, :employee_id)
      end

      def serializer
        Api::V1::DailyTaskSerializer
      end
    end
  end
end
