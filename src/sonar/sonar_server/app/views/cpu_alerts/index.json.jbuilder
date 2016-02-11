json.array!(@cpu_alerts) do |cpu_alert|
  json.extract! cpu_alert, :id, :machine_id, :addressee, :cpu_threshold, :check_interval, :triggered
  json.url cpu_alert_url(cpu_alert, format: :json)
end
