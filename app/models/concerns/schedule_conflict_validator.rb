class ScheduleConflictValidator < ActiveModel::Validator
  def validate(record)
    return unless record.user.is_a?(Student) && record.section.present?

    record.user.sections.reload.each do |existing_section|
      if days_overlap?(record.section, existing_section) &&
         times_overlap?(record.section, existing_section)
        record.errors.add(:base, "Schedule conflict detected. This section overlaps with an existing one.")
        break
      end
    end
  end

  private

  def days_overlap?(section, other_section)
    (section.days & other_section.days).any?
  end

  def times_overlap?(section, other_section)
    !(section.end_time <= other_section.start_time ||
      section.start_time >= other_section.end_time)
  end
end
