FactoryBot.define do
  factory :section do
    association :teacher
    association :subject
    association :classroom
    days { "MWF" }
    start_time { "09:00:00" }
    end_time { "09:50:00" }
  end
end
