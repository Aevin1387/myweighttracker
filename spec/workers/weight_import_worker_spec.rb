require "spec_helper"

describe WeightImportWorker do
  let(:user) { create(:user) }
  let!(:measurements) { create_list(:measurement, 160, user: user) }
  let(:worker) { WeightImportWorker.new }

  it "should mark 50 records as imported to fitbit", vcr: true do
    FitbitApi.stub(:log_weight)
    FitbitApi.stub(:log_fat)
    expect do
      worker.perform(user.id, "fitbit")
    end.to change(Measurement.where(imported_to_fitbit: true), :count).by(50)
  end
end
