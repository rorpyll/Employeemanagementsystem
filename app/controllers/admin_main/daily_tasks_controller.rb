# frozen_string_literal: true

module AdminMain
  class DailyTasksController < ApplicationController
    def index
      @daily_tasks = if current_employee.is_admin?
                       DailyTask.all.order(created_at: :desc).page params[:page]
                     else
                       current_employee.daily_tasks.order(created_at: :desc).page params[:page]
                     end
    end

    def show
      if current_employee.is_admin?
        @daily_task = DailyTask.find_by_id params[:id]
      else
        @daily_task = current_employee.daily_tasks.find_by_id params[:id]

        redirect_to root_path, alert: I18n.t('employee.unauthorize_error') unless @daily_task.present?
      end
    end

    private

    def set_daily_task
      @daily_task = DailyTask.find_by_id params[:id]
      redirect_to root_path, alert: I18n.t('employee.not_found') unless @daily_task.present?
    end

    def params_daily_task
      params.require(:daily_task).permit(:description, :employee_id)
    end
  end
end
