class CreateStorageMetrics < ActiveRecord::Migration
  def change
    create_table :storage_metrics do |t|
      
      t.belongs_to  :machine, index: true

      t.float   :storage

      t.timestamps null: false
      
    end
  end
end
