# frozen_string_literal: true

module V1
  class EmployeesController < ApplicationController
    # before_action :authenticate_employee!
    # load_and_authorize_resource
    protect_from_forgery with: :null_session
    before_action :set_employee, only: %i[update]
    # GET /employees or /employees.json
    def index
      @employees = Employee.search(params[:search])
      @designations = Designation.all
      render json: {
        data: ActiveModelSerializers::SerializableResource.new(@employees, each_serializer: EmployeeSerializer),
        message: ['employee list fetched successfully'],
        status: 200,
        type: 'Success'
      }
    end

    # GET /employees/1 or /employees/1.json
    def show
      employee = if current_employee.is_hr?
                   Employee.find(params[:id])
                 else
                   current_employee
                 end
      render json: {
        data: ActiveModelSerializers::SerializableResource.new(employee, serializer: EmployeeSerializer),
        status: 200,
        type: 'Success'
      }
    end

    def update
      set_designation
      if @employee.update(employee_params)
        render json: {
          data: ActiveModelSerializers::SerializableResource.new(@employee, serializer: EmployeeSerializer),
          message: ['employee profile successfully update'], status: 200
        }
      else
        render json: employee, status: 404
      end
    end

    private

    def set_designation
      @designations = Designation.all
      @skills = Skill.all
      @roles = Role.all
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find_by_id params[:id]
      render json: { message: ['Employee not found'] }, status: 404 unless @employee.present?
    end

    def employee_params
      params.require(:employee).permit(:name, :father_name, :mother_name, :phone_number, :address, :email, :bank_name,
                                       :account_number, :pan_card_number, :aadhar_card_number, :primary_skill, :password, :password_confirmation, :designation_id, :role_id, :image, :date_of_birth)
    end
  end
end
