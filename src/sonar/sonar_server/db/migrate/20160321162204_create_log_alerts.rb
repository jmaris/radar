class CreateLogAlerts < ActiveRecord::Migration
  def change
    create_table :log_alerts do |t|
      t.string  :logger_type
      t.string  :path
      t.string  :arguments
      t.integer :match_amount

      t.timestamps null: false
    end
  end
end
