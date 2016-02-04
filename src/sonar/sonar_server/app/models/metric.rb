class Metric < ActiveRecord::Base
# Attributes: machine_id
belongs_to :machine
validates :machine, :presence => true #machine_id

    def self.api(protocol, host, port, path)
        response = RestClient.get("#{protocol}://#{host}:#{port}/sonar_api_v1/#{path}") #not very smart to hardcode the API version, but works for now.
        JSON.parse(response,symbolize_names: true) rescue {}
    end

    def self.save_metrics_dj(machine_id)

        machine = Machine.find(machine_id)
        
        api_live = api(machine.protocol,machine.host,machine.port,"live")
        api_sysinfo = api(machine.protocol,machine.host,machine.port,"sysinfo")
        CpuMetric.create("machine_id" => machine_id, "cpu" => api_live[:cpu_percentage])
        RamMetric.create("machine_id" => machine_id, "ram" => (api_live[:ram_bytes].to_f/api_sysinfo[:ram][:total_bytes].to_f*100).round(2))

        Metric.delay(run_at: machine.update_interval.minutes.from_now).save_metrics_dj(machine_id)
    end
end