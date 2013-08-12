require "spec_helper"

describe WeightImportController do
  context "user not signed in" do
    it "should redirect the user" do
      get :new
      expect(response).to redirect_to(root_path)
    end
  end

  context "user signed in" do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    it "should load" do
      get :new
      expect(response).to be_success
      expect(response.code).to eq("200")
    end
  end

  context "#create" do
    let(:user) { create(:user) }
    let(:file) { fixture_file_upload("import_csv.csv", "text/csv" ) }

    before do
      sign_in user
    end

    it "creates measurement records" do
      expect do
        post :create, measurement: { csv: file }
      end.to change(Measurement, :count).by(4)
    end
  end
end
