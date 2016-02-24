class CpuAlert < ActiveRecord::Base
    
    acts_as :alert

    validates       :threshold, presence: true, numericality: true

    private

    def self.is_higher(live_api,cpu_alert_id)
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
