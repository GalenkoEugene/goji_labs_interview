require "rails_helper"

RSpec.describe ScheduleConflictValidator do
  let(:student) { create(:student) }

  let(:section1) do
    create(:section,
      days: %w[Mon Wed],
      start_time: "10:00",
      end_time: "11:20"
    )
  end

  let(:section2) do
    create(:section,
      days: %w[Mon],
      start_time: "11:00",
      end_time: "11:50"
    )
  end

  let(:section3) do
    create(:section,
      days: %w[Tue],
      start_time: "14:00",
      end_time: "15:20"
    )
  end

  before { create(:enrollment, user: student, section: section1) }

  it "adds error if schedule overlaps" do
    enrollment = build(:enrollment, user: student, section: section2)

    expect(enrollment.valid?).to eq(false)
    expect(enrollment.errors[:base]).to include("Schedule conflict detected. This section overlaps with an existing one.")
  end

  it "is valid if schedule does not overlap" do
    enrollment = build(:enrollment, user: student, section: section3)

    expect(enrollment.valid?).to eq(true)
  end
end
