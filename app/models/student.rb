class Student < User
  has_many :enrollments, foreign_key: 'user_id', dependent: :destroy
  has_many :sections, through: :enrollments
end
