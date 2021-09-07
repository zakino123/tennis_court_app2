FactoryBot.define do
  factory :court do
    name { "tenniscourt" }
    address { "埼玉県蓮田市黒浜" }
    association :user
    price { 100 }
    hour { 1 }
    number { 5 }
    latitude { "test" }
    longitude { "test" }
    remarks { "test" }
    image { "test" }
  end
end
