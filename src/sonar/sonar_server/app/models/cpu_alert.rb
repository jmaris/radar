class CpuAlert < ActiveRecord::Base
    
    acts_as :alert

    validates       :threshold, presence: true, numericality: true

    private

    def self.is_higher(cpu_alert_id)
        machine = Machine.find(Alert.where(actable_type: "CpuAlert", actable_id: cpu_alert_id).first.machine_id)
        live_api = Machine.api(machine.protocol,machine.host,machine.port,"live")

        live_cpu = live_api[:cpu_percentage]
        cpu_alert = CpuAlert.find(cpu_alert_id)
        threshold = cpu_alert.threshold

        if live_cpu > threshold
            true
        else
            false
        end
    end
end
