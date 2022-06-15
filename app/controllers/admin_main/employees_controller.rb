# frozen_string_literal: true

module AdminMain
  class EmployeesController < ApplicationController
    def index
      redirect_to new_admin_main_employee_path
    end

    def new
      @employee = Employee.new
      @designations = Designation.all
      @skills = Skill.all
      @roles = Role.all
    end

    def create
      @designations = Designation.all
      @skills = Skill.all
      @roles = Role.all
      @employee = Employee.new(employee_params)
      if @employee.save
        redirect_to @employee
      else
        render :new
      end
    end

    def edit
      @employee = Employee.find_by_id params[:id]
      @designations = Designation.all
      @roles = Role.all
    end

    def update
      @employee = Employee.find_by_id params[:id]
      @designations = Designation.all
      @roles = Role.all
      if params[:employee].present?
        if @employee.update(employee_params)
          redirect_to employee_path
        else
          render :edit
        end
      else
        redirect_to admin_main_employee_path
      end
    end

    def destroy
      @employee = Employee.find(params[:id])
      if @employee.destroy
        redirect_to employees_path
      else
        render :index
      end
    end

    private

    def employee_params
      params.require(:employee).permit(:designation_id, :role_id, :name, :father_name, :mother_name, :date_of_birth,
                                       :phone_number, :email, :address, :bank_name, :account_number, :pan_card_number, :aadhar_card_number, :primary_skill, :password, :password_confirmation, :joining_date, :gender)
    end
  end
end
