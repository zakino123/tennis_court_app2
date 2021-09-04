FactoryBot.define do
  factory :court do
    name { "tenniscourt" }
    address { "address" }
    association :user
  end
  factory :court2 do
    name { "tenniscourt" }
    address { "address" }
    association :user2
  end
end
