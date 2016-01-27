class CreateMachines < ActiveRecord::Migration
  def change
    create_table :machines do |t|
      t.string :protocol
      t.string :host
      t.integer :port

      t.timestamps null: false
    end
  end
end
