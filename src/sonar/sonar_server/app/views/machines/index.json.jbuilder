json.array!(@machines) do |machine|
  json.extract! machine, :id, :url
  json.url machine_url(machine, format: :json)
end
