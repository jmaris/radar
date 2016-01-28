class CreateRamMetrics < ActiveRecord::Migration
  def change
    create_table :ram_metrics do |t|

      t.timestamps null: false
    end
  end
end
