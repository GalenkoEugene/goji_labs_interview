FactoryBot.define do
  factory :classroom do
    name { "#{Faker::Address.community} Hall #{rand(100..599)}" }
  end
end
