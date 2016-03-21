class CreateRamAlerts < ActiveRecord::Migration
  def change
  create_table  :ram_alerts do |t|
    t.float     :threshold
    t.integer   :duration

    t.timestamps null: false
  end
  end
end
