class Teacher < User
  has_many :sections, foreign_key: 'teacher_id', dependent: :destroy
end
