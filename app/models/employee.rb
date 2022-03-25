class Employee < ApplicationRecord
  has_many :performances
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  mount_uploader :image
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end