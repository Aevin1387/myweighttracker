class Measurement < ActiveRecord::Base
  validates :measured_at, :user, presence: :true
  validate :one_measurement_per_user, on: :create

  belongs_to :user

  def one_measurement_per_user
  end
end
