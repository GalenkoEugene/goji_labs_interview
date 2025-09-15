class Section < ApplicationRecord
  belongs_to :subject
  belongs_to :classroom
  belongs_to :teacher, class_name: "Teacher"

  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, source: :user

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :days, presence: true

  validate :duration_validation

  private

  def duration_validation
    return if end_time.blank? || start_time.blank?

    duration_in_minutes = ((end_time - start_time) / 60).to_i
    unless [50, 80].include?(duration_in_minutes)
      errors.add(:base, "Section duration must be 50 or 80 minutes")
    end
  end
end
