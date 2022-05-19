# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ActionController::Base
      def get_employee
        Employee.first
      end

      def serializer_data(employee)
        ActiveModelSerializers::SerializableResource.new(employee, serializer: Api::V1::EmployeeSerializer)
      end
    end
  end
end
