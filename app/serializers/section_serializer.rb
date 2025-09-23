# == Schema Information
#
# Table name: sections
#
#  id           :bigint           not null, primary key
#  days         :string           default([]), is an Array
#  end_time     :time
#  start_time   :time
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  classroom_id :bigint           not null
#  subject_id   :bigint           not null
#  teacher_id   :integer
#
# Indexes
#
#  index_sections_on_classroom_id  (classroom_id)
#  index_sections_on_subject_id    (subject_id)
#
# Foreign Keys
#
#  fk_rails_...  (classroom_id => classrooms.id)
#  fk_rails_...  (subject_id => subjects.id)
#
class SectionSerializer < ActiveModel::Serializer
  attributes :id, :days, :start_time, :end_time

  belongs_to :subject
  belongs_to :teacher
  belongs_to :classroom

  def start_time
    I18n.l(object.start_time, format: :time)
  end

  def end_time
    I18n.l(object.end_time, format: :time)
  end
end
