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
