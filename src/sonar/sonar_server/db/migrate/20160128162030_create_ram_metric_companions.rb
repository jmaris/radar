class CreateRamMetricCompanions < ActiveRecord::Migration
  def change
    create_table :ram_metric_companions do |t|

      t.integer :ram_metric_id
      t.float :ram
      t.float :swap
      
      t.timestamps null: false
    end
  end
end
