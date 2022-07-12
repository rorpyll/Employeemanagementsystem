# frozen_string_literal: true

# Attendence controller
class AttendencesController < InheritedResources::Base
  # load_and_authorize_resource
  before_action :set_attendance, only: %i[show edit]
  def index
    @attendences = current_employee.attendences
  end

  def show
    @attendences = Attendence.where(employee_id: @attendence.employee_id)
  end

  def create
    last_attendance = Attendence.where(checkin_time: Time.zone.now - 2.minutes..Time.zone.now,
                                       employee_id: current_employee.id).last
    if last_attendance.nil?
      Attendence.create(employee_id: current_employee.id, checkin_time: Time.zone.now,
                        status: 'Present', checkin_ip_address: request.remote_ip)
    else
      last_attendance.update_column('checkout_time', nil)
    end
    redirect_to root_path
  end

  def update_attendence
    attendence = current_employee.todays_last_attendence
    attendence.update(checkout_time: Time.zone.now, checkout_ip_address: request.remote_ip)
    redirect_to root_path
  end

  def set_attendance
    @attendence = current_employee.attendences.find_by_id params[:id]
    redirect_to root_path, alert: I18n.t('employee.not_found') unless @attendence.present?
  end
end
