# frozen_string_literal: true

module Api
  module V1
    class HolidaysController < ApplicationController
      # before_action :authenticate_employee!
      skip_before_action :verify_authenticity_token

      # GET /employees/1 or /employees/1.json
      def index
        data = Holiday.all
        serializer = Api::V1::HolidaySerializer
        render json: {
          data: serializer_data(data, serializer),
          message: ['list of holiday '], status: 200, type: 'Success'
        }
      end

      private

      def holiday_params
        params.require(:holiday).permit(:holiday_date, :holiday_name)
      end
    end
  end
end
