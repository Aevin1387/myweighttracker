require "spec_helper"

describe WithingsImport do
  let(:user) { create(:user) }
  let(:import_csv) { File.open("spec/fixtures/import_csv.csv", "r") }
  let(:importer) { WithingsImport.new(user, import_csv) }

  it "should create weight import records" do
    expect do
      importer.start_import
    end.to change(WeightImport, :count).by(4)
  end

  it "enqueues a WeightImportWorker job" do
    WeightImportWorker.should_receive(:perform_async)
    importer.start_import
  end
end
