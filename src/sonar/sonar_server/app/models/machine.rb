class Machine < ActiveRecord::Base
    validates :protocol,    presence: true
    validates :host,        presence: true, uniqueness: true
    validates :port,        presence: true, numericality: true
    has_many :metrics
end
