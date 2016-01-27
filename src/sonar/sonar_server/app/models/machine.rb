class Machine < ActiveRecord::Base
    validates_presence_of :protocol, :host, :port
    validates_numericality_of :port
    validates_uniqueness_of :host
    has_many :metrics
end
