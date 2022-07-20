# frozen_string_literal: true

module AdminMain
  class DailyTasksController < ApplicationController
    before_action :set_daily_task, only: %i[show]
    def index
      @daily_tasks = if current_employee.is_admin?
                       DailyTask.all.order(created_at: :desc).page params[:page]
                     else
                       current_employee.daily_tasks.order(created_at: :desc).page params[:page]
                     end
      @daily_task = DailyTask.search(params[:dailytask])
      @employees = Employee.all
    end

    def show
      @daily_task = if current_employee.is_admin?
                      DailyTask.find_by_id params[:id]
                    else
                      current_employee.daily_tasks.find_by_id params[:id]
                    end
    end

    private

    def set_daily_task
      @daily_task = DailyTask.find_by_id params[:id]
      redirect_to root_path, { notice: 'NOT FOUND :)' } unless @daily_task.present?
    end

    def params_daily_task
      params.require(:daily_task).permit(:description, :employee_id)
    end
  end
end
