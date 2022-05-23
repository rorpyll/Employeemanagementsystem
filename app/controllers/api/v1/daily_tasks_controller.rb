# frozen_string_literal: true

module Api
  module V1
    class DailyTasksController < ApplicationController
      # before_action :authenticate_employee!
      skip_before_action :verify_authenticity_token

      def index
        employee = get_employee
        data = employee.daily_tasks.order(created_at: :desc)
        render json: {
          data: serializer_data(data, serializer),
          message: ['daily task list '], status: 200, type: 'Success'
        }
      end

      def show
        data = DailyTask.find(params[:id])
        render json: {
          data: serializer_data(data, serializer),
          message: ['show daily task  '], status: 200, type: 'Success'
        }
      end

      def create
        data = DailyTask.new(params_daily_task)
        if data.save
          render json: {
            data: serializer_data(data, serializer),
            message: ['Successfully daily task create '], status: 200, type: 'Success'
          }
        else
          render json: data
        end
      end

      def update
        data = DailyTask.find(params[:id])
        if data.update(params_daily_task)
          render json: {
            data: serializer_data(data, serializer),
            message: ['Successfully daily task  update'], status: 200, type: 'Success'
          }
        else
          render json: data
        end
      end

      private

      def params_daily_task
        params.require(:daily_task).permit(:description, :employee_id)
      end

      def serializer
        Api::V1::DailyTaskSerializer
      end
    end
  end
end
