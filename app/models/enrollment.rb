# == Schema Information
#
# Table name: enrollments
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  section_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_enrollments_on_section_id              (section_id)
#  index_enrollments_on_user_id_and_section_id  (user_id,section_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (section_id => sections.id)
#  fk_rails_...  (user_id => users.id)
#
class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :section

  validates :user_id, uniqueness: { scope: :section_id, message: "is already enrolled in this section" }
  validate :user_is_a_student

  validates_with ScheduleConflictValidator

  private

  def user_is_a_student
    errors.add(:user, "must be a student to enroll") unless user&.type == Student.name
  end
end
