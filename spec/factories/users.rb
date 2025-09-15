FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    factory :student, class: 'Student' do
      type { Student.name }
    end

    factory :teacher, class: 'Teacher' do
      type { Teacher.name }
    end
  end
end
