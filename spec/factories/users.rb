FactoryBot.define do
  factory :user do
    name { "test" }
    sequence(:email) { |n| "test#{n}@example.com"}
    password {"foobar"}
  end
  factory :user2 do
    name { "test" }
    email { "test@example.com" }
    password {"foobar"}
  end
end
