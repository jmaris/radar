class CreateLogAlerts < ActiveRecord::Migration
  def change
    create_table :log_alerts do |t|
      t.string :logger_type
      t.string :path
      t.string :arguments

      t.timestamps null: false
    end
  end
end
