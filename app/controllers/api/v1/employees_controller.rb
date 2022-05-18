# frozen_string_literal: true

module Api
  module V1
    class EmployeesController < ApplicationController
      # before_action :authenticate_employee!
      # load_and_authorize_resource
      before_action :set_employee, only: [:update]
      protect_from_forgery with: :null_session

      # GET /employees/1 or /employees/1.json
      def show
        @employee = get_employee
        render json: EmployeeSerializer.new(employee, {} ) 
        # render json: {
        #   data: serializer_data(@employee),
        #   message: ['employee profile successfully update'], status: 200, type: 'Success'
        # }
      end

      # PATCH /employees/1 or /employees/1.json
      def update
        @employee = Employee.find_by_id params[:id]
        if @employee.update(employee_params)
          render json: {
            data: serializer_data(@employee),
            message: ['employee profile successfully update'], status: 200, type: 'Success'
          }
        else
          render json: @employee, status: 404
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_employee
        @employee = Employee.find(params[:id])
        render json: { message: ['Employee not found'] }, status: 404 unless @employee.present?
      end

      def serializer_data(employee)
        byebug
        ActiveModelSerializers::SerializableResource.new(employee, serializer: EmployeeSerializer)
      end

      def employee_params
        params.require(:employee).permit(:password, :password_confirmation)
      end
    end
  end
end