class Salary < ApplicationRecord
  belongs_to :employee, dependent: :destroy
  before_save :update_total_working_days
  before_save :total_earnings
  before_save :total_deductions
   
  validates :salary, presence: true
  validates :month, presence: true
  def update_total_working_days
    self.total_working_days = employee.working_days
    self.leaves = employee.leave_total
  end

  def total_earnings
    days = Date.today.all_month.count
    working_days = days -  month_of_days.count
    earning_days = (working_days - leaves)
    self.earnings = (salary/working_days)*earning_days
  end

  def total_deductions
    self.deductions = salary - earnings
  end

  def month_of_days
     start_date = Date.today - 4.day# your start
     end_date = Date.today - 5.day + 1.month 
     my_days = [0] 
     result = (start_date..end_date).to_a.select {|k| my_days.include?(k.wday)}
  end
end
