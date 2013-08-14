class WeightImportWorker
  include Sidekiq::Worker

  def perform(user_id, type)
    @user = User.find(user_id)
    @type = type
    @limit = 100

    if imports_remaining?
      start_import
    end
  end

  def imports_remaining?
    records.exists?
  end

  def records
    @user.measurements.where("imported_to_#{@type}" => false)
  end

  def api
    @api ||= setup_api
  end

  def setup_api
    case @type
    when "fitbit"
      FitbitApi.new(@user.oauth_token, @user.oauth_token_secret, ENV["FITBIT_CONSUMER_KEY"], ENV["FITBIT_CONSUMER_SECRET"])
    else
      nil
    end
  end

  def start_import
    imports = records.limit(50)

    imports.each do |import|
      return unless @limit > 0

      import_weight(import)
      import_fat(import)

      import.update("imported_to_#{@type}" => true)
    end

    WeightImportWorker.perform_at(1.hour.from_now, @user.id, @type) if imports_remaining?
  end

  def import_weight(import)
    return unless @limit > 0 && import.weight.present?

    api.log_weight(import.measured_at, import.weight)

    @limit -= 1
  end

  def import_fat(import)
    return unless @limit > 0 && import.fat.present?
    api.log_fat(import.measured_at, import.fat)
    @limit -= 1
  end
end
