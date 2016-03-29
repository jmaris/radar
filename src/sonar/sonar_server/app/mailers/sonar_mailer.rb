class SonarMailer < ApplicationMailer
    default from: 'alerts@sonar.com'

    def cpu_alert_email(cpu_alert_id)

        cpu_alert       = CpuAlert.find(cpu_alert_id)
        machine         = Machine.find(cpu_alert.machine_id)

        @alert          = cpu_alert
        @addressee      = cpu_alert.addressee
        @machine_id     = machine.id
        @machine_alias  = machine.alias
        @threshold      = cpu_alert.threshold
        @custom_message = cpu_alert.custom_message

        mail(to: @addressee, subject: 'Sonar CPU alert')

    end

    def cpu_unalert_email(cpu_alert_id)

        cpu_alert       = CpuAlert.find(cpu_alert_id)
        machine         = Machine.find(cpu_alert.machine_id)

        @alert          = cpu_alert
        @addressee      = cpu_alert.addressee
        @machine_id     = machine.id
        @machine_alias  = machine.alias
        @threshold      = cpu_alert.threshold

        mail(to: @addressee, subject: 'Sonar CPU alert solved')

    end

    def ram_alert_email(ram_alert_id)

        ram_alert       = RamAlert.find(ram_alert_id)
        machine         = Machine.find(ram_alert.machine_id)

        @alert          = ram_alert
        @addressee      = ram_alert.addressee
        @machine_id     = machine.id
        @machine_alias  = machine.alias
        @threshold      = ram_alert.threshold
        @custom_message = ram_alert.custom_message

        mail(to: @addressee, subject: 'Sonar RAM alert')

    end

    def ram_unalert_email(ram_alert_id)

        ram_alert       = RamAlert.find(ram_alert_id)
        machine         = Machine.find(ram_alert.machine_id)

        @alert          = ram_alert
        @addressee      = ram_alert.addressee
        @machine_id     = machine.id
        @machine_alias  = machine.alias
        @threshold      = ram_alert.threshold

        mail(to: @addressee, subject: 'Sonar RAM alert solved')

    end

    def log_alert_email(log_alert_id)

        log_alert       = LogAlert.find(log_alert_id)
        machine         = Machine.find(log_alert.machine_id)

        @alert          = log_alert
        @addressee      = log_alert.addressee
        @machine_id     = machine.id
        @machine_alias  = machine.alias
        @logger_type    = log_alert.logger_type
        @path           = log_alert.path
        @arguments      = log_alert.arguments
        @custom_message = log_alert.custom_message

        mail(to: @addressee, subject: 'Sonar log alert')

    end

    def log_unalert_email(log_alert_id)

        log_alert       = LogAlert.find(log_alert_id)
        machine         = Machine.find(log_alert.machine_id)

        @alert          = log_alert
        @addressee      = log_alert.addressee
        @machine_id     = machine.id
        @machine_alias  = machine.alias

        mail(to: @addressee, subject: 'Sonar log alert solved')

    end

    def storage_alert_email(storage_alert_id)

        storage_alert       = StorageAlert.find(storage_alert_id)
        machine             = Machine.find(storage_alert.machine_id)

        @alert              = storage_alert
        @addressee          = storage_alert.addressee
        @machine_id         = machine.id
        @machine_alias      = machine.alias
        @threshold          = storage_alert.threshold
        @storage_path       = storage_alert.path
        @custom_message     = storage_alert.custom_message

        mail(to: @addressee, subject: 'Sonar storage alert')
    end

        def storage_unalert_email(storage_alert_id)

        storage_alert       = StorageAlert.find(storage_alert_id)
        machine             = Machine.find(storage_alert.machine_id)

        @alert              = storage_alert
        @addressee          = storage_alert.addressee
        @machine_id         = machine.id
        @machine_alias      = machine.alias
        @threshold          = storage_alert.threshold
        @storage_path       = storage_alert.path

        mail(to: @addressee, subject: 'Sonar storage alert solved')
    end
end
