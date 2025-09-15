# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  first_name :string
#  last_name  :string
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Student < User
  has_many :enrollments, foreign_key: "user_id", dependent: :destroy
  has_many :sections, through: :enrollments
end
