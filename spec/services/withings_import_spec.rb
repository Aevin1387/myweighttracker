require "spec_helper"

describe WeightImport do
  let(:user) { create(:user) }
  let(:import_csv) { File.open("spec/fixtures/import_csv.csv", "r") }
  let(:importer) { WeightImport.new(user, import_csv) }

  it "should create measurements" do
    expect do
      importer.start_import
    end.to change(Measurement, :count).by(4)
  end
end
