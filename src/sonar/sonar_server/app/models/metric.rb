class Metric < ActiveRecord::Base
# Attributes: machine_id
belongs_to :machine
validates :machine, :presence => true #machine_id

    def self.api(protocol, host, port, path)
        response = RestClient.get("#{protocol}://#{host}:#{port}/sonar_api_v1/#{path}") #not very smart to hardcode the API version, but works for now.
        JSON.parse(response,symbolize_names: true)
    end

    def self.save_metrics_dj(machine_id)
        machine = Machine.find(machine_id)
        
        api_live = api(machine.protocol,machine.host,machine.port,"live")
        CpuMetric.create("machine_id" => machine_id, "cpu" => api_live[:cpu_percentage], "load_average_1min" => api_live[:cpu_load_average].first, "load_average_5min" => api_live[:cpu_load_average].second, "load_average_15min" => api_live[:cpu_load_average].third)

        Metric.delay(run_at: machine.update_interval.minutes.from_now).save_metrics_dj(machine_id)
    end
end