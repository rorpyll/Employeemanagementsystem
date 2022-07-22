FactoryBot.define do
  factory :attendence do
    checkin_time { "2022-03-28 12:51:52" }
    checkout_time { "2022-03-28 12:51:52" }
    status { "MyString" }
    employee { 1 }
  end
end
