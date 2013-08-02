class WeightImportWorker
  include Sidekiq::Worker

  def perform(user_id)
    @user = User.find(user_id)
    @limit = 100

    if @user.imports_remaining?
      start_import
    end
  end

  def start_import
    @api = FitbitApi.new(@user.oauth_token, @user.oauth_token_secret, ENV["FITBIT_CONSUMER_KEY"], ENV["FITBIT_CONSUMER_SECRET"])
    imports = @user.weight_imports.limit(100)

    imports.each do |import|
      return unless @limit > 0

      import_weight(import)
      import_fat(import)

      import.destroy
    end

    WeightImportWorker.perform_at(1.hour.from_now, @user.id) if @user.imports_remaining?
  end

  def import_weight(import)
    return unless @limit > 0 && import.weight.present?

    @api.log_weight(import.weighed_at, import.weight)

    @limit -= 1
  end

  def import_fat(import)
    return unless @limit > 0 && import.fat.present?
    @api.log_fat(import.weighed_at, import.fat)
    @limit -= 1
  end
end
