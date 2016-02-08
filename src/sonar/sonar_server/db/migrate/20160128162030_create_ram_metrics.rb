class CreateRamMetrics < ActiveRecord::Migration
  def change
    create_table :ram_metrics do |t|

      t.integer :machine_id

      t.float   :ram
      # t.float   :swap #swap is not yet available

      t.timestamps null: false
    end
  end
end
