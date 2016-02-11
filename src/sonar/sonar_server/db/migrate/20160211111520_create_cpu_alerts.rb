class CreateCpuAlerts < ActiveRecord::Migration
  def change
    create_table  :cpu_alerts do |t|
      t.integer   :machine_id
      t.string    :addressee
      t.float     :cpu_threshold
      t.integer   :check_interval
      t.boolean   :triggered

      t.timestamps null: false
    end
  end
end
