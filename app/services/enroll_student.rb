class EnrollStudent
  # TODO: After refactoring could be removed, skip due to time limitations
  Result = Struct.new(:success?, :enrollment, :errors, keyword_init: true)

  def self.call(student:, section:)
    enrollment = Enrollment.new(user: student, section: section)

    if enrollment.save
      Result.new(success?: true, enrollment: enrollment, errors: [])
    else
      Result.new(success?: false, enrollment: nil, errors: enrollment.errors.full_messages)
    end
  end
end
