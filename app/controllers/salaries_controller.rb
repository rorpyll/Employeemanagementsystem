# frozen_string_literal: true

# salaries controller
class SalariesController < InheritedResources::Base
  before_action :authenticate_employee!
  before_action :set_salary, only: %i[show]
  after_action :update_download_satus, only: %i[show]
  load_and_authorize_resource

  def  index
    if current_employee.is_hr?
      @salaries = Salary.all
    else
      @salaries = current_employee.salaries
    end
  end

  def show
      respond_to do |format|
        format.html
        format.pdf do
          render template: "salaries/show.html.erb",
            pdf: "Salary of Month: #{@salary.id}"
        end
      end
  end



  private
  
  def set_salary
    @salary = Salary.find_by_id params[:id]
    redirect_to root_path, alert: I18n.t('employee.not_found') unless @salary.present?
  end

  def update_download_satus
      @salary.update(download_status: false)
  end
end
