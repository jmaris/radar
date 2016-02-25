class StorageMetric < ActiveRecord::Base
    belongs_to :machine
    # validates_associated :machine
    
    validates :storage, presence: true, numericality: true
    validates :machine_id, presence: true, numericality: { only_integer: true }
end
