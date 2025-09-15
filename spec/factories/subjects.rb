# == Schema Information
#
# Table name: subjects
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :subject do
    name { "#{Faker::Educator.course_name} #{rand(100..499)}" }
  end
end
