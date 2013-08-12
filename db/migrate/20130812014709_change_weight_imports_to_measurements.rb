class ChangeWeightImportsToMeasurements < ActiveRecord::Migration
  def change
    rename_table :weight_imports, :measurements

    change_table :measurements do |t|
      t.rename :weighed_at, :measured_at
      t.timestamps
    end
  end
end
