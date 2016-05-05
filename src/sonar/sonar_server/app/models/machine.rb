class Machine < ActiveRecord::Base
  validates       :alias, presence: true
  validates       :protocol, presence: true, format: { with: /\A(https?)\Z/i }
  validates       :host, presence: true, uniqueness: true
  validates       :port, presence: true, numericality: { only_integer: true }, inclusion: 1..65535
  validates       :update_interval, presence: true, numericality: { only_integer: true }, inclusion: { in: 1..1440 }

  has_many        :cpu_metrics,       dependent: :destroy
  has_many        :ram_metrics,       dependent: :destroy
  has_many        :storage_metrics,   dependent: :destroy

  has_many        :alerts,            dependent: :destroy
  # has_one         :delayed_job,       dependent: :destroy

  after_save      :sysinfo_update # this updates the machine with static info provided by the sysinfo API
  after_save      :sync_alerts
  after_create    :launch_metric_save_metrics_dj # schedules a delayed job to check every N minutes and update the performance charts

  private

  def self.api(protocol, host, port, path)
    response = RestClient.get("#{protocol}://#{host}:#{port}/sonar_api_v1/#{path}") # not very smart to hardcode the API version, but works for now.
    JSON.parse(response,symbolize_names: true)
  rescue
    RestClient::Exception
    'error'
  end

  def sysinfo_update
    machine_id = self.id

    machine = Machine.find(machine_id)
    api_sysinfo = Machine.api(machine.protocol, machine.host,machine.port, 'sysinfo')

    self.update_column(:hostname, api_sysinfo[:hostname])
    self.update_column(:os, api_sysinfo[:os][:family])
    self.update_column(:cpu_model, api_sysinfo[:cpu][:model])
    self.update_column(:cpu_cores, api_sysinfo[:cpu][:cores])
    self.update_column(:cpu_architecture, api_sysinfo[:cpu][:architecture])
    self.update_column(:ram_total_bytes, api_sysinfo[:ram][:total_bytes])
    # self.update_column(:swap_total_bytes, api_sysinfo[:swap][:total_bytes])
    self.update_column(:storage_total_bytes, api_sysinfo[:storage][:total_bytes])
  end

  def sync_alerts
    machine_id = self.id
    update_interval = self.update_interval

    for cpu_alert_id in CpuAlert.where(machine_id: machine_id).ids
      cpu_alert = CpuAlert.find(cpu_alert_id)
      cpu_alert.check_interval = update_interval
      if cpu_alert.duration < update_interval
        cpu_alert.duration = update_interval
      end
      cpu_alert.save
    end

    for ram_alert_id in RamAlert.where(machine_id: machine_id).ids
      ram_alert = RamAlert.find(ram_alert_id)
      ram_alert.check_interval = update_interval
      if ram_alert.duration < update_interval
        ram_alert.duration = update_interval
      end
      ram_alert.save
    end
  end

  def launch_metric_save_metrics_dj
    Metric.save_metrics_dj(self.id)
  end
end
