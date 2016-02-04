class Machine < ActiveRecord::Base
    validates       :protocol,        presence: true
    validates       :host,            presence: true, uniqueness: true
    validates       :port,            presence: true, numericality: true, inclusion: 1..65535
    validates       :update_interval, presence: true, numericality: true
    has_many        :metrics
    # attr_accessible :protocol, :host, :port, :update_interval

    after_save :sysinfo_update

    private
    def sysinfo_update
        machine_id = Machine.all.sort_by{ |s| s[:updated_at]}.last.id

        machine = Machine.find(machine_id)
        api_sysinfo = Metric.api(machine.protocol,machine.host,machine.port,"sysinfo")

        machine.update(
            'hostname'              => api_sysinfo[:hostname],
            'os'                    => api_sysinfo[:os][:family],
            'cpu_model'             => api_sysinfo[:cpu][:model],
            'cpu_cores'             => api_sysinfo[:cpu][:cores],
            'cpu_architecture'      => api_sysinfo[:cpu][:architecture],
            'ram_total_bytes'       => api_sysinfo[:ram][:total_bytes],
            'storage_total_bytes'   => api_sysinfo[:storage][:total_bytes]
            )
    end
end
