class WeightImport < ActiveRecord::Base
  validates :weighed_at, presence: :true

  belongs_to :user
end
