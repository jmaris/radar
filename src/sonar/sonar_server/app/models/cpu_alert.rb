class CpuAlert < Alert
    belongs_to              :machine

    validates               :cpu_threshold, presence: true, numericality: true
    after_create            :launch_cpu_alert_check_dj

    private

    def launch_cpu_alert_check_dj # DJ stands for "Delayed Job"
        cpu_alert_id = self.id
        CpuAlert.check_dj(cpu_alert_id)
    end

    def self.check_dj(cpu_alert_id)

        cpu_alert = CpuAlert.find(cpu_alert_id)
        machine_id = cpu_alert.machine_id
        machine = Machine.find(machine_id)
        live_cpu = Machine.api(machine.protocol,machine.host,machine.port,"live")[:cpu_percentage]
        cpu_threshold = cpu_alert.cpu_threshold

        if cpu_alert.triggered == false
            if live_cpu > cpu_threshold
                SonarMailer.cpu_alert_email(cpu_alert_id).deliver_later
                cpu_alert.triggered = 1
                cpu_alert.save
            end
        elsif cpu_alert.triggered == true
            if live_cpu < cpu_threshold
                cpu_alert.triggered = 0
                cpu_alert.save
            end
        end
        CpuAlert.delay(run_at: cpu_alert.check_interval.minutes.from_now).check_dj(cpu_alert.id)
    end
end
