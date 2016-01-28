class CreateCpuMetrics < ActiveRecord::Migration
  def change
    create_table :cpu_metrics do |t|

      t.timestamps null: false
    end
  end
end
