class Section < ApplicationRecord
  belongs_to :subject
  belongs_to :classroom
  belongs_to :teacher, class_name: 'Teacher'

  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, source: :user

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :days, presence: true
end
