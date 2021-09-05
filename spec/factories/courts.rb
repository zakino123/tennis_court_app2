FactoryBot.define do
  factory :court do
    name { "tenniscourt" }
    address { "address" }
    association :user
  end
end
