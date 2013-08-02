class WeightImportController < ApplicationController
  before_filter :authenticate_user!

  def new
  end

  def create
    import = WithingsImport.new(current_user, import_params[:csv].tempfile)

    if import.start_import
      render :show
    else
      flash.now.alert = import.errors
      render :new
    end
  end

  def show
  end

  protected

  def import_params
    return {} unless params.has_key?(:weight_import)
    params.require(:weight_import).permit(:csv)
  end
end
