class Alert < ActiveRecord::Base
  actable

  belongs_to    :machine

  # has_one         :delayed_job,       dependent: :destroy #delayed_job_id

  # validates     :check_interval, presence: true, numericality: { only_integer: true }, inclusion: { in: 1..1440 }
  validates     :addressee, presence: true, format: { with: /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/i }
  validate      :machine

  after_create  :init # sets triggered to false
  
  def machine
    unless Machine.exists?(self.machine_id)
      errors.add(:machine_id, 'does not exist')
    end
  end

  def check_dj
    alert = self
    alert_id = id

    machine = Machine.find(alert.machine_id)

    actable_id
    # actable_type = self.actable_type

    if actable_type.constantize.is_higher(actable_id)
      alert_email_trigger(alert_id)
    else
      alert_email_untrigger(alert_id)
    end

    delayed_job = alert.delay(run_at: machine.update_interval.minutes.from_now).check_dj

    alert.delayed_job_id = delayed_job.id
    alert.save
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
      when 'CpuAlert'
        SonarMailer.cpu_unalert_email(actable_id).deliver_later
      when 'RamAlert'
        SonarMailer.ram_unalert_email(actable_id).deliver_later
      when 'StorageAlert'
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

    unless actable_alert.triggered
      case actable_type
      when 'CpuAlert'
        SonarMailer.cpu_alert_email(actable_id).deliver_later
      when 'RamAlert'
        SonarMailer.ram_alert_email(actable_id).deliver_later
      when 'StorageAlert'
        SonarMailer.storage_alert_email(actable_id).deliver_later
      end
      alert.triggered = true
      alert.save
    end
  end
end
