# frozen_string_literal: true

module Hr
  # hr can create company monthly salary details
  class MonthlySalariesController < ApplicationController
    def index
      @monthly_salaries = MonthlySalary.all
    end

    def new
      @monthly_salary = MonthlySalary.new
    end

    def create
      @monthly_salary = MonthlySalary.new(monthly_params)
      if @monthly_salary.save
        redirect_to hr_monthly_salaries_path
      else
        render :new
      end
    end

    def update
      @monthly_salary = MonthlySalary.find_by_id(params[:id])
      if @monthly_salary.update(company_level: params[:company_level])
        redirect_to hr_monthly_salaries_path
      else
        render :edit
      end
    end

    private

    def monthly_params
      params.require(:monthly_salary).permit(:month, :monthly_working_days, :company_level)
    end
  end
end
