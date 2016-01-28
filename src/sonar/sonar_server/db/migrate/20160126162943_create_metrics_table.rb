class CreateMetricsTable < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
        t.integer :machine_id
        
        t.timestamps null: false
    end
end
end
