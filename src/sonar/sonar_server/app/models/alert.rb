class Alert < ActiveRecord::Base
    belongs_to :machine, dependent: :delete
    validates_associated :machine

    validate :machine

    def check

        alerts = Alert.all.to_a.map(&:id)

        alerts.each do |alert_id|
            machine_id = Alert.find(alert_id).machine_id
            machine = Machine.find(machine_id)
            live_cpu = Machine.api(machine.protocol,machine.host,machine.port,"live")[:cpu_percentage]
            cpu_threshold = Alert.find(alert_id).cpu_threshold
            if live_cpu > cpu_threshold
                
            end
        end
    end

    private
    def machine
        errors.add(:machine_id, "is invalid") unless Machine.exists?(self.machine_id)
    end
end
