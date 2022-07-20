# frozen_string_literal: true

class DailyTask < ApplicationRecord
  belongs_to :employee
  validates :description, presence: true
  paginates_per 10

  def self.search(search)
    if search
      daily_task = []
      search.each do |s|
        daily_task << DailyTask.joins(:employee).where('employees.name LIKE ?', "%#{s}%")
      end
      daily_task.flatten
    else
      all
    end
  end
end
