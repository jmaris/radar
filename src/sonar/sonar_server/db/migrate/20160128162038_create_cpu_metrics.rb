class CreateCpuMetrics < ActiveRecord::Migration
  def change
    create_table :cpu_metrics do |t|

      t.belongs_to  :machine, index: true

      t.float   :cpu
      # t.float   :load_average_1min
      # t.float   :load_average_5min
      # t.float   :load_average_15min

      t.timestamps null: false
    end
  end
end
