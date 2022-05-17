# frozen_string_literal: true

module V1
  class EmployeeSerializer < ActiveModel::Serializer
    attributes :id, :name, :email, :father_name, :mother_name, :phone_number, :address, :image, :leave_count,
               :department, :bank_name, :account_number, :pan_card_number, :aadhar_card_number, :salary, :primary_skill, :date_of_birth, :role_id, :designation_id

    def designation
      {
        id: object.designation.id,
        name: object.designation.name
      }
    end
  end
end
