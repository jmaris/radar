class SonarMailer < ApplicationMailer
    default from: 'alerts@sonar'

    def alert_email(alert_id)
       
        alert           = Alert.find(alert_id)
        machine         = Machine.find(alert.machine_id)

        @addressee      = alert.addressee
        @machine_id     = machine.id
        @cpu_threshold  = alert.cpu_threshold

        mail(to: @addressee, subject: 'Sonar alert')
    end
end
