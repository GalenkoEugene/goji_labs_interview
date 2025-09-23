# == Schema Information
#
# Table name: classrooms
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Classroom < ApplicationRecord
  has_many :sections

  validates :name, presence: true, uniqueness: true
end
