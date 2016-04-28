class ChangeIntegerLimitInMachinesTable < ActiveRecord::Migration
  def change
    change_column :machines, :ram_total_bytes, :integer, limit: 8
    # update_column :machines, :swap_total_bytes, :integer, limit: 8
    change_column :machines, :storage_total_bytes, :integer, limit: 8
  end
end
