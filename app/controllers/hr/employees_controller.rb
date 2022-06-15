class Hr::EmployeesController < ApplicationController
    #before_action :set_employee, only: %i[new, create]
    load_and_authorize_resource

    def index
        redirect_to new_hr_employee_path
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


    private

    def employee_params
        params.require(:employee).permit(:designation_id, :role_id, :name, :father_name, :mother_name, :date_of_birth, :phone_number, :email, :address, :bank_name, :account_number, :pan_card_number, :aadhar_card_number, :primary_skill, :password, :password_confirmation, :joining_date, :gender)
    end
end
