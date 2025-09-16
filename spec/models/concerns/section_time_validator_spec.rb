require "rails_helper"

RSpec.describe SectionTimeValidator do
  context "with valid times" do
    it "is valid with 50 minute duration" do
      section = build(:section, start_time: "09:00", end_time: "09:50")
      expect(section).to be_valid
    end

    it "is valid with 80 minute duration" do
      section = build(:section, start_time: "10:00", end_time: "11:20")
      expect(section).to be_valid
    end
  end

  context "with invalid start time" do
    it "adds error when start_time is before 07:30" do
      section = build(:section, start_time: "07:00", end_time: "07:50")

      expect(section.valid?).to eq(false)
      expect(section.errors[:start_time]).to include("must be after 07:30")
    end
  end

  context "with invalid end time" do
    it "adds error when end_time is after 22:00" do
      section = build(:section, start_time: "21:30", end_time: "22:30")

      expect(section.valid?).to eq(false)
      expect(section.errors[:end_time]).to include("must be before 22:00")
    end
  end

  context "with invalid duration" do
    it "adds error when duration is not 50 or 80 minutes" do
      section = build(:section, start_time: "12:00", end_time: "12:30")

      expect(section.valid?).to eq(false)
      expect(section.errors[:base]).to include("Section duration must be 50 or 80 minutes")
    end
  end

  context "when start_time or end_time is nil" do
    it "is invalid if start_time is nil" do
      section = build(:section, start_time: nil, end_time: "09:50")
      expect(section).not_to be_valid
      expect(section.errors[:start_time]).to include("can't be blank")
    end

    it "is invalid if end_time is nil" do
      section = build(:section, start_time: "09:00", end_time: nil)
      expect(section).not_to be_valid
      expect(section.errors[:end_time]).to include("can't be blank")
    end
  end
end
