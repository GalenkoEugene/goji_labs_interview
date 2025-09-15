class EnrollStudent
  Result = Struct.new(:success?, :enrollment, :errors, keyword_init: true)

  def self.call(student:, section:)
    new(student: student, section: section).call
  end

  def initialize(student:, section:)
    @student = student
    @section = section
    @errors = []
  end

  def call
    if schedule_conflict?
      @errors << "Schedule conflict detected. This section overlaps with an existing one."
    end

    if @student.sections.include?(@section)
      @errors << "Student is already enrolled in this section."
    end

    if @errors.empty?
      enrollment = Enrollment.create(user: @student, section: @section)
      Result.new(success?: true, enrollment: enrollment, errors: [])
    else
      Result.new(success?: false, enrollment: nil, errors: @errors)
    end
  end

  private

  attr_reader :student, :section

  def schedule_conflict?
    student.sections.any? do |existing_section|
      days_overlap?(existing_section) && times_overlap?(existing_section)
    end
  end

  def days_overlap?(other_section)
    section.days.chars.any? { |day| other_section.days.include?(day) }
  end

  def times_overlap?(other_section)
    (section.start_time < other_section.end_time) && (section.end_time > other_section.start_time)
  end
end
