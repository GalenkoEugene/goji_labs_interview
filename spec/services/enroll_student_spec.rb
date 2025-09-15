require "rails_helper"

RSpec.describe EnrollStudent, type: :service do
  subject(:enroll_student) { described_class }

  let(:student)   { create(:student) }
  let(:teacher)   { create(:teacher) }
  let(:subject_)  { create(:subject) }
  let(:classroom) { create(:classroom) }

  def build_section(start_time:, end_time:, days:)
    create(:section,
      subject: subject_,
      teacher: teacher,
      classroom: classroom,
      start_time: start_time,
      end_time: end_time,
      days: days
    )
  end

  shared_examples "enrollment attempt" do |expected_success:, error: nil|
    it "returns #{expected_success ? 'success' : 'failure'}" do
      enroll_student.call(student: student, section: first_section)
      result = enroll_student.call(student: student, section: second_section)

      expect(result.success?).to eq(expected_success)
      expect(result.errors).to include(error) if error
    end
  end

  context "when enrolling without conflicts" do
    let(:first_section) do
      build_section(
        start_time: "08:00",
        end_time: "08:50",
        days: [ "Mon", "Wed", "Fri" ]
      )
    end

    context "if days are different" do
      let(:second_section) do
        build_section(
          start_time: "08:00",
          end_time: "08:50",
          days: [ "Tue", "Thu" ]
        )
      end

      include_examples "enrollment attempt", expected_success: true
    end

    context "if times don't overlap" do
      let(:second_section) do
        build_section(
          start_time: "09:00",
          end_time: "09:50",
          days: [ "Mon", "Wed", "Fri" ]
        )
      end

      include_examples "enrollment attempt", expected_success: true
    end
  end

  context "when enrolling with conflicts" do
    let(:first_section) do
      build_section(
        start_time: "08:00",
        end_time: "08:50",
        days: [ "Mon", "Wed", "Fri" ]
      )
    end

    context "if days and times both overlap" do
      let(:second_section) do
        build_section(
          start_time: "08:30",
          end_time: "09:20",
          days: [ "Mon", "Wed", "Fri" ]
        )
      end

      include_examples "enrollment attempt",
        expected_success: false,
        error: "Schedule conflict detected. This section overlaps with an existing one."
    end

    context "if the same section is added again" do
      let(:second_section) { first_section }

      include_examples "enrollment attempt",
        expected_success: false,
        error: "Student is already enrolled in this section."
    end
  end

  context "edge cases for overlap logic" do
    let(:first_section) do
      build_section(
        start_time: "08:00",
        end_time: "08:50",
        days: [ "Mon" ]
      )
    end

    context "back-to-back sections (end_time == start_time)" do
      let(:second_section) do
        build_section(
          start_time: "08:50",
          end_time: "09:40",
          days: [ "Mon" ]
        )
      end

      include_examples "enrollment attempt", expected_success: true
    end

    context "when one section fully contains another" do
      let(:first_section) do
        build_section(
          start_time: "08:00",
          end_time: "09:00",
          days: [ "Tue" ]
        )
      end

      let(:second_section) do
        build_section(
          start_time: "08:20",
          end_time: "08:40",
          days: [ "Tue" ]
        )
      end

      include_examples "enrollment attempt", expected_success: false
    end
  end
end
