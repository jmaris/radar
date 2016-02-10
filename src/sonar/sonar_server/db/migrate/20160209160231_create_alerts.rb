class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.belongs_to  :machine, index: true

      t.string  :addressee
      t.integer :check_interval
      t.float   :cpu_threshold
      t.float   :ram_threshold
      t.float   :swap_threshold

      t.timestamps null: false
    end
  end
end
