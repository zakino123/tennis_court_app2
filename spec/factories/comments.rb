FactoryBot.define do
  factory :comment do
    context { 'test' }
    association :user
    association :court
  end
end
