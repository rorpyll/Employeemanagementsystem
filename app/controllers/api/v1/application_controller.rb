# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ActionController::Base
      def get_employee
        Employee.first
      end

      def serializer_data(data,serializer)
        ActiveModelSerializers::SerializableResource.new(data, serializer: serializer)
      end


      # def serializer_data(holiday)
      #   ActiveModelSerializers::SerializableResource.new(holiday, serializer: Api::V1::HolidaySerializer)
      # end
    end
  end
end
