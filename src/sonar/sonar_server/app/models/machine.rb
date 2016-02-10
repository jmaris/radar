class Machine < ActiveRecord::Base
    validates       :protocol,        presence: true
    validates       :host,            presence: true, uniqueness: true
    validates       :port,            presence: true, numericality: { only_integer: true }, inclusion: 1..65535
    validates       :update_interval, presence: true, numericality: { only_integer: true }

    has_many        :cpu_metrics
    has_many        :ram_metrics
    has_many        :alerts

    after_save      :sysinfo_update
    after_create    :launch_metric_save_metrics_dj
    # after_create    :check_alias
    # after_destroy   :destroy_metrics
    before_destroy  :destroy_delayed_job

    private

    def self.api(protocol, host, port, path)
        response = RestClient.get("#{protocol}://#{host}:#{port}/sonar_api_v1/#{path}") #not very smart to hardcode the API version, but works for now.
        JSON.parse(response,symbolize_names: true) rescue {}
    end

    def destroy_delayed_job
        dj_id = self.delayed_job_id
        dj = Delayed::Job.find(dj_id)
        dj.destroy
    end

    def check_alias
        
    end

    def sysinfo_update
        machine_id = self.id

        machine = Machine.find(machine_id)
        api_sysinfo = Machine.api(machine.protocol,machine.host,machine.port,"sysinfo")

        self.update_column(:hostname, api_sysinfo[:hostname])
        self.update_column(:os, api_sysinfo[:os][:family])
        self.update_column(:cpu_model, api_sysinfo[:cpu][:model])
        self.update_column(:cpu_cores, api_sysinfo[:cpu][:cores])
        self.update_column(:cpu_architecture, api_sysinfo[:cpu][:architecture])
        self.update_column(:ram_total_bytes, api_sysinfo[:ram][:total_bytes])
        # self.update_column(:swap_total_bytes, api_sysinfo[:swap][:total_bytes])
        self.update_column(:storage_total_bytes, api_sysinfo[:storage][:total_bytes])
    end
    
    def launch_metric_save_metrics_dj
        machine_id = self.id
        Metric.save_metrics_dj(machine_id)
    end
end
