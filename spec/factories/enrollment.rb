FactoryBot.define do
  factory :enrollment do
    association :user, factory: :student
    association :section
  end
end
