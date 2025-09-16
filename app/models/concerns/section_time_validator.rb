class SectionTimeValidator < ActiveModel::Validator
  DURATION_OPTIONS = [ 50, 80 ].freeze # in minutes
  MIN_START_TIME = Time.utc(2000, 1, 1, 7, 30) # 07:30
  MAX_END_TIME = Time.utc(2000, 1, 1, 22, 0)   # 22:00

  def validate(record)
    return if record.end_time.blank? || record.start_time.blank?

    if invalid_duration?(record.start_time, record.end_time)
      record.errors.add(:base, "Section duration must be 50 or 80 minutes")
    end

    if invalid_start_time?(record.start_time)
      record.errors.add(:start_time, "must be after 07:30")
    end

    if invalid_end_time?(record.end_time)
      record.errors.add(:end_time, "must be before 22:00")
    end
  end

  private

  def invalid_start_time?(time)
    time < MIN_START_TIME
  end

  def invalid_end_time?(time)
    time > MAX_END_TIME
  end

  def invalid_duration?(start_time, end_time)
    duration_in_minutes = ((end_time - start_time) / 60).to_i
    !DURATION_OPTIONS.include?(duration_in_minutes)
  end
end
