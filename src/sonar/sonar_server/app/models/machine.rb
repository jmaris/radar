class Machine < ActiveRecord::Base
    validates :protocol,        presence: true
    validates :host,            presence: true, uniqueness: true
    validates :port,            presence: true, numericality: true, inclusion: 1..65535
    validates :update_interval, presence: true, numericality: true
    has_many  :metrics
end
