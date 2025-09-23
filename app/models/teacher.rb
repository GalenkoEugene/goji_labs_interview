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
# Indexes
#
#  index_users_on_type  (type)
#
class Teacher < User
  has_many :sections, foreign_key: "teacher_id", dependent: :destroy
end
