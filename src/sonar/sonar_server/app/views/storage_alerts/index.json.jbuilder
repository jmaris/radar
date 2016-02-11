json.array!(@storage_alerts) do |storage_alert|
  json.extract! storage_alert, :id, :machine_id, :addressee, :storage_threshold, :check_interval
  json.url storage_alert_url(storage_alert, format: :json)
end
