class StorageAlert < Alert
    belongs_to              :machine

    validates               :storage_threshold, presence: true, numericality: true
    after_create            :launch_storage_alert_check_dj

    private

    def launch_storage_alert_check_dj # DJ stands for "Delayed Job"
        storage_alert_id = self.id
        StorageAlert.check_dj(storage_alert_id)
    end

    def self.check_dj(storage_alert_id)

        storage_alert = StorageAlert.find(storage_alert_id)
        machine_id = storage_alert.machine_id
        machine = Machine.find(machine_id)

        storage_path = "storage/"
        storage_path << ERB::Util.url_encode(storage_alert.path)

        api_live    = Machine.api(machine.protocol,machine.host,machine.port,"live")
        api_sysinfo = Machine.api(machine.protocol,machine.host,machine.port,"sysinfo")
        api_storage = Machine.api(machine.protocol,machine.host,machine.port,storage_path)

        blocks_used = api_storage[:blocks] - api_storage[:blocks_free]
        live_storage = (blocks_used*100)/api_storage[:blocks].to_f

        storage_threshold = storage_alert.storage_threshold

        if storage_alert.triggered == false
            if live_storage > storage_threshold
                SonarMailer.storage_alert_email(storage_alert_id).deliver_later
                storage_alert.triggered = 1
                storage_alert.save
            end
        elsif storage_alert.triggered == true
            if live_storage < storage_threshold
                storage_alert.triggered = 0
                storage_alert.save
            end
        end
        StorageAlert.delay(run_at: storage_alert.check_interval.minutes.from_now).check_dj(storage_alert.id)
    end
end
