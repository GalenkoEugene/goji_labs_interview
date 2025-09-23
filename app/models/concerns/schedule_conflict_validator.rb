class ScheduleConflictValidator < ActiveModel::Validator
  def validate(record)
    return unless record.user.is_a?(Student) && record.section.present?

    if record.user.sections.overlapping(record.section.start_time, record.section.end_time, record.section.days).exists?
      record.errors.add(:base, "Schedule conflict detected. This section overlaps with an existing one.")
    end
  end
end
