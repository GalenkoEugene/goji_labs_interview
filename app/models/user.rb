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
class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
end
