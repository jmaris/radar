class CreateMachines < ActiveRecord::Migration
  def change
    create_table :machines do |t|

        #manual parameters

        t.string    :alias
        t.string    :protocol # url: #{machine.protocol}://#{machine.host}:#{machine.port}
        t.string    :host
        t.integer   :port
        t.integer   :update_interval

        # Delayed Job
        t.references   :delayed_job

        # static system information
        t.string    :hostname
        t.string    :os # os.family + os.release from the API
        t.string    :cpu_model
        t.integer   :cpu_cores
        t.string    :cpu_architecture
        t.integer   :ram_total_bytes
        # t.integer   :swap_total_bytes # not yet implemented
        t.integer   :storage_total_bytes

      t.timestamps null: false
    end
  end
end
