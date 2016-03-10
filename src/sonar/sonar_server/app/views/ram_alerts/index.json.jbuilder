json.array!(@ram_alerts) do |ram_alert|
  json.extract! ram_alert, :id, :threshold
  json.url ram_alert_url(ram_alert, format: :json)
end
