class Metric < ActiveRecord::Base
# Attributes: machine_id
    belongs_to :machine
    validates :machine, :presence => true #machine_id
end