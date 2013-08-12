class AddFitbitAndWithingsImportToMeasurements < ActiveRecord::Migration
  def change
    add_column :measurements, :imported_to_fitbit, :boolean, default: false, null: false
    add_column :measurements, :imported_to_withings, :boolean, default: false, null: false

    add_index :measurements, :imported_to_fitbit
    add_index :measurements, :imported_to_withings
  end
end
