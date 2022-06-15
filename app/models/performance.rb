class Performance < ApplicationRecord
  belongs_to :employee, dependent: :destroy
  validates :month, presence: true
  validates :points, presence: true
end
