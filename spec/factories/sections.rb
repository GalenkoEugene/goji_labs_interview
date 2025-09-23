# == Schema Information
#
# Table name: sections
#
#  id           :bigint           not null, primary key
#  days         :string           default([]), is an Array
#  end_time     :time
#  start_time   :time
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  classroom_id :bigint           not null
#  subject_id   :bigint           not null
#  teacher_id   :integer
#
# Indexes
#
#  index_sections_on_classroom_id  (classroom_id)
#  index_sections_on_subject_id    (subject_id)
#
# Foreign Keys
#
#  fk_rails_...  (classroom_id => classrooms.id)
#  fk_rails_...  (subject_id => subjects.id)
#
FactoryBot.define do
  factory :section do
    association :teacher
    association :subject
    association :classroom
    days { Section::AVAILABLE_DAYS.sample(3) }
    start_time { "09:00:00" }
    end_time { "09:50:00" }
  end
end
