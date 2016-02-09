class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string :machine_id
      t.string :addressee
      t.string :cpu_threshold
      t.string :ram_threshold
      t.string :swap_threshold

      t.timestamps null: false
    end
  end
end
