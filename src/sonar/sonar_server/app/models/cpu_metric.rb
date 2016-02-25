class CpuMetric < ActiveRecord::Base
    belongs_to :machine
    # validates_associated :machine
    
    validates :cpu, presence: true, numericality: true
    validates :machine_id, presence: true, numericality: { only_integer: true }
end
