class CreateCpuMetricCompanions < ActiveRecord::Migration
  def change
    create_table :cpu_metric_companions do |t|

      t.integer :cpu_metric_id
      t.float :cpu
      t.timestamps null: false
    end
  end
end
