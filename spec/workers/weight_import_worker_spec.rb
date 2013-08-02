require "spec_helper"

describe WeightImportWorker do
  let(:user) { create(:user) }
  let!(:weight_imports) { create_list(:weight_import, 160, user: user) }
  let(:worker) { WeightImportWorker.new }

  it "should remove 50 imports", vcr: true do
    expect do |variable|
      worker.perform(user.id)
    end.to change(WeightImport, :count).by(-50)
  end
end
