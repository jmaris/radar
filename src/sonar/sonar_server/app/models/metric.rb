class Metric < ActiveRecord::Base
    validates_presence_of :machine
    validates_presence_of :cpu
    belongs_to :machine
end