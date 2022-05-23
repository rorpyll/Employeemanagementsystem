FactoryBot.define do
  factory :leaf do
    leave_type { "MyString" }
    from_date { "2022-03-30" }
    till_date { "2022-03-30" }
    leave_starts { "MyString" }
    leave_end { "MyString" }
    total_days { 1 }
    resion { "MyString" }
    leave_status { nil }
    employee_id { 1 }
  end
end
