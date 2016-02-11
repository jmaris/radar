class CreateStorageAlerts < ActiveRecord::Migration
  def change
    create_table  :storage_alerts do |t|
      t.integer   :machine_id
      t.string    :addressee
      t.float     :storage_threshold
      t.integer   :check_interval
      t.boolean   :triggered

      t.timestamps null: false
    end
  end
end
