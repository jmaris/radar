class RamAlert < ActiveRecord::Base

	acts_as :alert

    validates       :threshold, presence: true, numericality: true, inclusion: {in: 0..100}

    private

    def self.is_higher(ram_alert_id)
        machine 		= Machine.find(Alert.where(actable_type: "RamAlert", actable_id: ram_alert_id).first.machine_id)
        live_api 		= Machine.api(machine.protocol,machine.host,machine.port,"live")
        sysinfo_api 	= Machine.api(machine.protocol,machine.host,machine.port,"sysinfo")

        live_ram 		= live_api[:ram_bytes]
        sysinfo_ram 	= sysinfo_api[:ram][:total_bytes]
        ram_percentage	= (live_ram.to_f / sysinfo_ram.to_f)*100
        ram_alert 		= RamAlert.find(ram_alert_id)
        threshold 		= ram_alert.threshold

        if ram_percentage > threshold
            true
        else
            false
        end
        
    end
end
