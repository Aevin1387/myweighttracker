require "spec_helper"

describe Measurement do
  context "validations" do
    it { should validate_presence_of :measured_at }
    it { should validate_presence_of :user }
  end

  context "associations" do
    it { should belong_to :user }
  end
end
