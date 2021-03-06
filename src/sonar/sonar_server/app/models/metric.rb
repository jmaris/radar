class Metric < ActiveRecord::Base

    private

    def self.save_metrics_dj(machine_id)
        machine = Machine.find(machine_id)
        
        api_live = Machine.api(machine.protocol,machine.host,machine.port,"live")
        api_sysinfo = Machine.api(machine.protocol,machine.host,machine.port,"sysinfo")

        CpuMetric.create("machine_id" => machine_id, "cpu" => api_live[:cpu_percentage])
        RamMetric.create("machine_id" => machine_id, "ram" => (api_live[:ram_bytes].to_f/api_sysinfo[:ram][:total_bytes].to_f*100).round(2))
        StorageMetric.create("machine_id" => machine_id, "storage" => (api_live[:storage_bytes].to_f/api_sysinfo[:storage][:total_bytes].to_f*100).round(2))

        delayed_job = Metric.delay(run_at: machine.update_interval.minutes.from_now).save_metrics_dj(machine_id)

        machine.delayed_job_id = delayed_job.id
        machine.save
    end
end