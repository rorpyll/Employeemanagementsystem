# frozen_string_literal: true

# employeemodel
class Employee < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  self.inheritance_column = 'not_sti'
  has_many :performances, dependent: :destroy
  has_many :salaries, dependent: :destroy
  has_many :attendences, dependent: :destroy
  has_many :leafs, dependent: :destroy
  belongs_to  :designation, dependent: :destroy
  belongs_to  :role, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :daily_tasks, dependent: :destroy

  mount_uploader :image

  before_validation :check_joining_date, on: [:update]
  before_validation :date_of_birth_validation, on: [:update]

  validates :account_number, :aadhar_card_number, :pan_card_number,
            format: { with: Regexp.new(/\A[0-9 ()+-]+\z/), message: 'only allows number' }, on: :update
  validates :phone_number, presence: true, length: { maximum: 10, minimum: 10, message: 'Should be 10 digits' },
                           format: { with: Regexp.new(/\A[0-9 ()+-]+\z/), message: 'only allows number' }, on: :update
  def recalculate_leave_balance
    leafs.each do |leave|
      next unless leave.updated_at.min == Time.zone.now.min

      update_attribute(:leave_count, leave_count - 1) if leave.leave_status == 'accept' && leave_count.positive?
    end
  end

  def working_days
    created_at_time = []
    attendences.each do |attendence|
      if attendence.created_at.strftime('%m-%y') == Time.now.strftime('%m-%y')
        created_at_time << attendence.created_at.strftime('%d-%m-%y')
      end
    end
    days = created_at_time.uniq
    working_days = days.count
  end

  def leave_total
    count = 0
    leafs.each do |leaf|
      count += leaf.total_days if leaf.leave_status == 'accept'
    end
    return count - leave_count unless count.zero?

    count
  end

  def self.search(search)
    if search
      where(['name LIKE ? OR father_name LIKE ?', "%#{search}%", "%#{search}%"])
    else
      all
    end
  end

  def todays_last_attendence
    todays_attendences = attendences.where('checkin_time > ? AND checkin_time < ?', Date.today.beginning_of_day,
                                           Date.today.end_of_day)
    todays_attendences.max
  end

  def show_checkin?
    attendence = todays_last_attendence
    if attendence.present?
      return true if attendence.checkout_time.present?
    else
      true
    end
  end

  def date_of_birth_validation
    return errors.add :base, 'Employee Should be 18 +' unless date_of_birth.present? && date_of_birth < Time.now.to_date - 18.years
  end

  def check_joining_date
    return errors.add :base, "Joining Date Should Be Grether Then #{Time.now.to_date - 2.year} " unless joining_date.present? && joining_date > 2.years.ago
  end

  def is_hr?
    role&.name.upcase == 'HR'
  end

  def is_admin?
    role&.name == 'Admin'
  end
end
