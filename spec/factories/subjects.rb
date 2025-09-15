FactoryBot.define do
  factory :subject do
    name { "#{Faker::Educator.course_name} #{rand(100..499)}" }
  end
end
