require "spec_helper"

describe WeightImport do
  context "validations" do
    it { should validate_presence_of :weighed_at }
  end

  context "associations" do
    it { should belong_to :user }
  end
end
