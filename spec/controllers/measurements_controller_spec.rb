require "spec_helper"

describe MeasurementsController do
  context "user not signed in" do
    it "should redirect the user" do
      get :index
      expect(response).to redirect_to(root_path)
    end
  end

  context "user signed in" do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    it "should load" do
      get :index
      expect(response).to be_success
      expect(response.code).to eq("200")
    end
  end
end
