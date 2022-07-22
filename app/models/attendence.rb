# frozen_string_literal: true

class Attendence < ApplicationRecord
  self.inheritance_column = 'not_sti'
  belongs_to :employee

  before_save :working_hour
  before_validation :checkout_time_validation, on: [:update]

  def self.search(search)
    if search
      Employee.where(['name LIKE ? ', "%#{search}%"])
    else
      all
    end
  end

  private

  def working_hour
    unless checkout_time.nil?
      data = (checkout_time - checkin_time).to_i
      hour = (data / 3600).to_i
      min = ((data - (hour * 3600)) / 60).to_i
      sec = (data - (hour * 3600) - (min * 60)).to_i
      self.hour = "#{hour}:#{min}"
    end
  end

  def checkout_time_validation
    return errors.add :base, "Checkout time can't be blank" unless checkout_time.present?

    unless checkin_time.strftime('%d') == checkout_time.strftime('%d') && checkout_time.strftime('%H:%M') > checkin_time.strftime('%H:%M')
      errors.add :base,
                 "Please select date #{checkin_time.strftime('%d-%m-%Y')} and time greater then #{checkin_time.strftime('%H:%M')} :)"
    end
  end

  def self.search(params)
    if params[:start_date].blank? && params[:end_date].blank?
      Attendence.all
    else
      Attendence.where(created_at: params[:start_date]..params[:end_date], employee_id: params[:id])
    end
  end
end
