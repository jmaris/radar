class CreateMachines < ActiveRecord::Migration
  def change
    create_table :machines do |t|

        t.string    :protocol # url: #{machine.protocol}://#{machine.host}:#{machine.port}
        t.string    :host
        t.integer   :port
        t.string    :hostname
        t.integer   :update_interval

        # fixed data

        t.string    :cpu_model
        t.integer   :cpu_cores
        t.integer   :ram_total
        t.integer   :swap_total
        t.integer   :storage_total


      t.timestamps null: false
    end
  end
end
