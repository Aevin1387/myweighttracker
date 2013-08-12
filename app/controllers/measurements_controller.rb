class MeasurementsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @measurements = current_user.measurements.page(params[:page])
    respond_to do |format|
      format.html
      format.csv do
        send_data current_user.measurements.to_csv
      end
    end
  end
end
