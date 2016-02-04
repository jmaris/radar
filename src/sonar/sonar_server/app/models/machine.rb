class Machine < ActiveRecord::Base
    validates       :protocol,        presence: true
    validates       :host,            presence: true, uniqueness: true
    validates       :port,            presence: true, numericality: true, inclusion: 1..65535
    validates       :update_interval, presence: true, numericality: true
    has_many        :metrics
    # attr_accessible :protocol, :host, :port, :update_interval

    after_save      :sysinfo_update
    after_create    :launch_delayed_job_metrics

    private
    def sysinfo_update
        machine_id = Machine.all.sort_by{ |s| s[:updated_at]}.last.id

        machine = Machine.find(machine_id)
        api_sysinfo = Metric.api(machine.protocol,machine.host,machine.port,"sysinfo")

        self.update_column(:hostname, api_sysinfo[:hostname])
        self.update_column(:os, api_sysinfo[:os][:family])
        self.update_column(:cpu_model, api_sysinfo[:cpu][:model])
        self.update_column(:cpu_cores, api_sysinfo[:cpu][:cores])
        self.update_column(:cpu_architecture, api_sysinfo[:cpu][:architecture])
        self.update_column(:ram_total_bytes, api_sysinfo[:ram][:total_bytes])
        self.update_column(:storage_total_bytes, api_sysinfo[:storage][:total_bytes])
    end
    
    def launch_delayed_job_metrics
        machine_id = Machine.all.sort_by{ |s| s[:updated_at]}.last.id
        Metric.save_metrics_dj(machine_id)
    end
end
