json.array!(@log_alerts) do |log_alert|
  json.extract! log_alert, :id, :logger_type, :path, :arguments
  json.url log_alert_url(log_alert, format: :json)
end
