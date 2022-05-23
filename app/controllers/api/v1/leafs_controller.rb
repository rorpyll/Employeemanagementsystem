# frozen_string_literal: true

module Api
  module V1
    class LeafsController < ApplicationController
      # before_action :authenticate_employee!
      skip_before_action :verify_authenticity_token

      def index
        employee = get_employee
        data = Leaf.where(employee_id: employee.id).order('created_at DESC')
        serializer = Api::V1::LeafSerializer
        render json: {
          data: serializer_data(data, serializer),
          message: ['leaf list '], status: 200, type: 'Success'
        }
      end

      def create
        data = Leaf.new(leaf_params)
        serializer = Api::V1::LeafSerializer
        if data.save
          render json: {
            data: serializer_data(data, serializer),
            message: ['Successfully leave applied '], status: 200, type: 'Success'
          }
        else
          render json: data
        end
      end

      def update
        data = Leaf.find(params[:id])
        serializer = Api::V1::LeafSerializer
        if data.from_date > Time.now
          if data.update(leave_status: 'cancelled')
            render json: {
              data: serializer_data(data, serializer),
              message: ['leaf cancelled'], status: 200, type: 'Success'
            }
          else
            render json: data
          end
        else
          render json: data
        end
      end

      private

      def leaf_params
        params.require(:leaf).permit(:leave_type, :from_date, :till_date, :leave_starts, :leave_end, :total_days,
                                     :resion, :leave_status, :employee_id)
      end
    end
  end
end
