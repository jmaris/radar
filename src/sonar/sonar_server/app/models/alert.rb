class Alert < ActiveRecord::Base

    actable

    belongs_to		:machine

    validates   	:check_interval, presence: true, numericality: { only_integer: true }
    validates   	:addressee, presence: true
    validate    	:machine

    after_create	:init # sets the triggered value to false and starts the Delayed Job

    def machine
        errors.add(:machine_id, "does not exist") unless Machine.exists?(self.machine_id)
    end

    def check_dj
        alert = self
        alert_id = self.id

        machine_id = alert.machine_id
        machine = Machine.find(machine_id)
        live_api = Machine.api(machine.protocol,machine.host,machine.port,"live")

        actable_id = self.actable_id
        # actable_type = self.actable_type

        if actable_type.constantize.is_higher(actable_id)
            alert_email_trigger(alert_id)
        else
            alert_email_untrigger(alert_id)
        end
        
        alert.delay(run_at: alert.check_interval.minutes.from_now).check_dj
    end

    # private

    def init
        self.triggered = false
        self.save
        self.check_dj
    end

    def alert_email_untrigger(alert_id)
        alert = Alert.find(alert_id)
        type = alert.actable_type.constantize
        actable_alert = type.find(actable_id)

        if actable_alert.triggered
            case actable_type
            when "CpuAlert"
                SonarMailer.cpu_unalert_email(actable_id).deliver_later
            when "RamAlert"
                SonarMailer.ram_unalert_email(actable_id).deliver_later
            when "StorageAlert"
                SonarMailer.storage_unalert_email(actable_id).deliver_later
            end
            alert.triggered = false
            alert.save
        end
    end

    def alert_email_trigger(alert_id)
        alert = Alert.find(alert_id)
        type = alert.actable_type.constantize
        actable_alert = type.find(actable_id)

        if actable_alert.triggered
            puts "Alert triggered. Not triggering."
        else
            case actable_type
            when "CpuAlert"
                SonarMailer.cpu_alert_email(actable_id).deliver_later
            when "RamAlert"
                SonarMailer.ram_alert_email(actable_id).deliver_later
            when "StorageAlert"
                SonarMailer.storage_alert_email(actable_id).deliver_later
            end
            alert.triggered = true
            alert.save
        end
    end
end
