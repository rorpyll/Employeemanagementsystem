# frozen_string_literal: true

module Api
  module V1
    class PerformancesController < ApplicationController
      before_action :authenticate_employee!

      skip_before_action :verify_authenticity_token

      def index
        performance_data = Performance.all
        render json: {
          data: serializer_data(performance_data, performance_serializer),
          message: ['show performances '], status: 200, type: 'Success'
        }
      end

      private

      def performance_params
        params.require(:performance).permit(:points, :month, :from, :to, :employee_id)
      end

      def performance_serializer
        Api::V1::PerformanceSerializer
      end
    end
  end
end
