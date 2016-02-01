class CreateCpuMetricCompanions < ActiveRecord::Migration
  def change
    create_table :cpu_metric_companions do |t|

      t.integer :cpu_metric_id
      t.float   :cpu
      t.float   :load_average_1min
      t.float   :load_average_5min
      t.float   :load_average_15min

      t.timestamps null: false
    end
  end
end
