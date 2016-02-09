json.array!(@alerts) do |alert|
  json.extract! alert, :id, :machine_id, :addressee, :cpu_threshold, :ram_threshold, :swap_threshold
  json.url alert_url(alert, format: :json)
end
