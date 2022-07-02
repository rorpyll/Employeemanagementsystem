FactoryBot.define do
  factory :monthly_salary do
    month { "6" }
    monthly_working_days { 1 }
    company_level { true }
  end
end
