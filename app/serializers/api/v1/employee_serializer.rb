module Api
  module V1
    class EmployeeSerializer < ActiveModel::Serializer
      attributes :id, :name, :email, :father_name, :mother_name, :phone_number, :address, :image, :leave_count,
                 :department, :bank_name, :account_number, :pan_card_number, :aadhar_card_number, :salary, :primary_skill, :date_of_birth, :role_id, :designation

      def designation
        {
          name: object.designation.name
        }
      end
    end
  end
end