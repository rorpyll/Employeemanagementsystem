# frozen_string_literal: true

module AdminMain
  class EmployeesController < ApplicationController
    before_action :set_employee, only: %i[show destroy]
    before_action :set_designations, only: %i[new create]

    def index
      @employees = Employee.search(params[:search])
      @designations = Designation.all
    end

    def new
      @employee = Employee.new
    end

    def show; end

    def create
      @employee = Employee.new(employee_params)
      if @employee.save
        redirect_to admin_main_employee_path(@employee)
      else
        render :new
      end
    end

    def destroy
      @employee.destroy

      redirect_to admin_main_employees_path
    end

    private

    def set_designations
      @designations = Designation.all
      @skills = Skill.all
      @roles = Role.all
    end

    def set_employee
      @employee = Employee.find_by_id params[:id]
      redirect_to root_path, alert: I18n.t('@employee.not_found') unless @employee.present?
    end

    def employee_params
      params.require(:employee).permit(:designation_id, :role_id, :name, :father_name, :mother_name, :date_of_birth,
                                       :phone_number, :email, :address, :bank_name, :account_number, :pan_card_number, :aadhar_card_number, :primary_skill, :password, :password_confirmation, :joining_date, :gender)
    end
  end
end
