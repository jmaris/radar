json.array!(@machines) do |machine|
  json.extract! machine, :id, :protocol, :host, :port
  json.protocol machine_protocol(machine, format: :json)
  json.host machine_host(machine, format: :json)
  json.port machine_port(machine, format: :json)
end
