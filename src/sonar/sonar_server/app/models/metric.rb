class Metric < ActiveRecord::Base
# Attributes: machine_id
    belongs_to :machine
    validates :machine, :presence => true #machine_id
    def self.api_call(protocol, host, port)
        response = RestClient.get("#{protocol}://#{host}:#{port}/sonar_api_v1") #not very smart to hardcode the API version, but works for now.
        JSON.parse(response)
    end
end