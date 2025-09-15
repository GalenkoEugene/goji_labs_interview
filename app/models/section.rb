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
class Section < ApplicationRecord
  belongs_to :subject
  belongs_to :classroom
  belongs_to :teacher, class_name: "Teacher"

  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, source: :user

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :days, presence: true, inclusion: { in: %w[Mon Tue Wed Thu Fri] }

  validate :duration_validation

  private

  def duration_validation
    return if end_time.blank? || start_time.blank?

    duration_in_minutes = ((end_time - start_time) / 60).to_i
    unless [ 50, 80 ].include?(duration_in_minutes)
      errors.add(:base, "Section duration must be 50 or 80 minutes")
    end
  end
end
