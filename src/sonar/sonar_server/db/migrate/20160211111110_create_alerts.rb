class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.integer	:machine_id
      t.string 	:addressee
      t.integer :check_interval
      t.boolean :triggered
      # for inheritance
      t.actable

      t.timestamps null: false
    end
  end
end
