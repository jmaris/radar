class ChangeIntegerLimitInMachinesTable < ActiveRecord::Migration
  def change
    change_column :machines, :ram_total_bytes, :integer, limit: 16
    # update_column :machines, :swap_total_bytes, :integer, limit: 16
    change_column :machines, :storage_total_bytes, :integer, limit: 16
  end
end
