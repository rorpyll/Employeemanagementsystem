# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    name { Faker::Name.name }
    father_name { 'polo' }
    mother_name { 'kdgb' }
    date_of_birth { '13-05-2004' }
    phone_number { '2756392678' }
    address { 'ehugtue' }
    trainer_id { 1 }
    designation_id {}
    role_id {}
    email { Faker::Internet.email }
    image { '' }
    password { '123456' }
    account_number { '865924569376' }
    pan_card_number { '654937697358' }
    aadhar_card_number { '9346593659' }
    joining_date { '2022-05-23'}
  end
end
