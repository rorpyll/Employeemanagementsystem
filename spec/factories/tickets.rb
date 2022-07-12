FactoryBot.define do
  factory :ticket do
    status { nil }
    description { "MyText" }
    ticket_type { nil }
    employee { 1 }
  end
end
