class Alert < ActiveRecord::Base
	belongs_to		:machine

    validates   	:check_interval, presence: true, numericality: { only_integer: true }
    validates   	:addressee, presence: true
    validate    	:machine

    after_create	:init # sets the triggered value to false

    def machine
        errors.add(:machine_id, "is invalid") unless Machine.exists?(self.machine_id)
    end

    def init
        self.triggered = 0
        self.save
    end
end
