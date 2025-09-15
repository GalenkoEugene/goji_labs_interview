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
