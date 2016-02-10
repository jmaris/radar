class Alert < ActiveRecord::Base
    belongs_to              :machine, dependent: :delete

    validates               :check_interval, presence: true, numericality: { only_integer: true }
    validate                :machine

    after_create            :launch_alert_check_dj

    private

    def launch_alert_check_dj
        alert_id = self.id
        Alert.check_dj(alert_id)
    end

    def self.check_dj(alert_id)

        alert = Alert.find(alert_id)
        machine_id = alert.machine_id
        machine = Machine.find(machine_id)
        live_cpu = Machine.api(machine.protocol,machine.host,machine.port,"live")[:cpu_percentage]
        cpu_threshold = alert.cpu_threshold

        if live_cpu > cpu_threshold
            SonarMailer.alert_email(alert_id).deliver_later
        end

        Alert.delay(run_at: alert.check_interval.minutes.from_now).check_dj(alert.id)
    end

    def machine
        errors.add(:machine_id, "is invalid") unless Machine.exists?(self.machine_id)
    end
end
