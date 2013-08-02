require "spec_helper"

describe User do
  context "validations" do
    it { should validate_presence_of :full_name }
    it { should validate_presence_of :display_name }
    it { should validate_presence_of :uid }
    it { should validate_presence_of :oauth_token }
    it { should validate_presence_of :oauth_token_secret }
    it { should validate_presence_of :provider }
    it { should validate_presence_of :uid }
  end

  context "associations" do
    it { should have_many :weight_imports }
  end
end
