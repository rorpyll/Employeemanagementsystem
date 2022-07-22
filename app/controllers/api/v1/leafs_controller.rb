# frozen_string_literal: true

module Api
  module V1
    class LeafsController < ApplicationController
      before_action :authenticate_employee!
      skip_before_action :verify_authenticity_token

      def index
        leaf_data = current_employee.leafs.order('created_at DESC')
        render json: {
          data: serializer_data(leaf_data, leaf_serializer),
          message: ['leaf list '], status: 200, type: 'Success'
        }
      end

      def create
        leaf_data = Leaf.new(leaf_params)
        if leaf_data.save
          render json: {
            data: serializer_data(leaf_data, leaf_serializer),
            status: 200, type: 'Success'
          }
        else
          render json: leaf_data, status: 302, type: 'Found'
        end
      end

      def update
        leaf_data = Leaf.find(params[:id])
        if leaf_data.cancel_leave
          if leaf_data.update(leave_status: 'cancelled')
            render json: {
              data: serializer_data(leaf_data, leaf_serializer),
              message: ['leaf cancelled'], status: 200, type: 'Success'
            }
          else
            render json: leaf_data, status: 404, type: 'Not Found'
          end
        else
          render json: leaf_data, status: 304, type: 'Not Modified'
        end
      end

      private

      def leaf_serializer
        Api::V1::LeafSerializer
      end

      def leaf_params
        params.require(:leaf).permit(:leave_type, :from_date, :till_date, :leave_starts, :leave_end, :total_days,
                                     :reason, :leave_status, :employee_id)
      end
    end
  end
end
