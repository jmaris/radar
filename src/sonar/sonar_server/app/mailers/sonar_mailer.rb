class SonarMailer < ApplicationMailer
    default from: 'alerts@sonar.com'

    def cpu_alert_email(cpu_alert_id)

        cpu_alert       = CpuAlert.find(cpu_alert_id)
        machine         = Machine.find(cpu_alert.machine_id)

        @addressee      = cpu_alert.addressee
        @machine_id     = machine.id
        @machine_alias  = machine.alias
        @cpu_threshold  = cpu_alert.cpu_threshold

        mail(to: @addressee, subject: 'Sonar cpu_alert')

    end

    def storage_alert_email(storage_alert_id)

        storage_alert       = StorageAlert.find(storage_alert_id)
        machine             = Machine.find(storage_alert.machine_id)

        @addressee          = storage_alert.addressee
        @machine_id         = machine.id
        @machine_alias      = machine.alias
        @storage_threshold  = storage_alert.storage_threshold
        @storage_path       = storage_alert.path

        mail(to: @addressee, subject: 'Sonar storage_alert')

    end
end
