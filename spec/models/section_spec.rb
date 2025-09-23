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
require "rails_helper"

RSpec.describe Section, type: :model do
  def build_section(start_time:, end_time:, days: [ "Mon" ])
    build(:section,
      start_time: start_time,
      end_time: end_time,
      days: days
    )
  end

  shared_examples "valid section" do
    it "is valid" do
      expect(section).to be_valid
    end
  end

  shared_examples "invalid section" do |error_message|
    it "is invalid" do
      expect(section).not_to be_valid
      expect(section.errors.full_messages).to include(error_message)
    end
  end

  context "with valid durations" do
    context "50 minutes long" do
      let(:section) do
        build_section(
          start_time: "08:00",
          end_time: "08:50"
        )
      end

      include_examples "valid section"
    end

    context "80 minutes long" do
      let(:section) do
        build_section(
          start_time: "10:00",
          end_time: "11:20"
        )
      end

      include_examples "valid section"
    end
  end

  context "with invalid durations" do
    let(:section) do
      build_section(
        start_time: "09:00",
        end_time: "10:00" # 60 minutes
      )
    end

    include_examples "invalid section",
      "Section duration must be 50 or 80 minutes"
  end

  context "with missing attributes" do
    it "is invalid without start_time" do
      section = build_section(start_time: nil, end_time: "09:00")
      expect(section).not_to be_valid
      expect(section.errors[:start_time]).to include("can't be blank")
    end

    it "is invalid without end_time" do
      section = build_section(start_time: "08:00", end_time: nil)
      expect(section).not_to be_valid
      expect(section.errors[:end_time]).to include("can't be blank")
    end

    it "is invalid without days" do
      section = build_section(start_time: "08:00", end_time: "08:50", days: nil)
      expect(section).not_to be_valid
      expect(section.errors[:days]).to include("can't be blank")
    end
  end

  describe "days validation" do
    it "is invalid with unsupported days" do
      section = build_section(start_time: "08:00", end_time: "08:50", days: [ "Sat", "Sun", "INVALID" ])
      expect(section).not_to be_valid
      expect(section.errors[:days]).to include("is not included in the list")
    end

    it "is valid with supported days" do
      section = build_section(start_time: "08:00", end_time: "08:50", days: [ "Mon", "Wed", "Fri" ])
      expect(section).to be_valid
    end
  end
end
