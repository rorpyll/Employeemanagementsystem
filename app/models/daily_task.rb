# frozen_string_literal: true

class DailyTask < ApplicationRecord
  belongs_to :employee, dependent: :destroy
  validates :description, presence: true
  paginates_per 10
end
