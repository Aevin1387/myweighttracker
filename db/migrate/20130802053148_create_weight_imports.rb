class CreateWeightImports < ActiveRecord::Migration
  def change
    create_table :weight_imports do |t|
      t.integer :user_id
      t.float :weight
      t.float :fat
      t.date :weighed_at
    end

    add_index :weight_imports, :user_id
  end
end
