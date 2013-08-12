class Measurement < ActiveRecord::Base
  validates :measured_at, :user, presence: :true
  validate :one_measurement_per_user, on: :create

  belongs_to :user

  def one_measurement_per_user
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["Date", "Weight", "Rung", "Flag", "Comment"]
      all.each do |measurement|
        csv << [measurement.measured_at, measurement.weight, nil, nil, nil]
      end
    end
  end
end
