FactoryBot.define do
  factory :court do
    name { "tenniscourt" }
    address { "埼玉県蓮田市黒浜" }
    association :user
    price { 100 }
    number { 5 }
    latitude { 139.6732 }
    longitude { 35.9899 }
    remarks { "test" }
    image { "test" }
    reserve { "test" }
  end
end
