class Alert < ActiveRecord::Base
  actable

  belongs_to    :machine

  # has_one         :delayed_job,       dependent: :destroy #delayed_job_id

  #validates     :check_interval, presence: true, numericality: { only_integer: true }, inclusion: { in: 1..1440 }
  validates     :duration, presence: true, numericality: { only_integer: true }, inclusion: { in: 1..1440 }
  validates     :addressee, presence: true, format: { with: /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/i }
  validate      :machine
  validate      :duration_must_be_equal_to_or_higher_than_update_interval

  after_create  :init # sets triggered to false, copies check_interval from machine

  def machine
    unless Machine.exists?(self.machine_id)
      errors.add(:machine_id, 'does not exist')
    end
  end

  def duration_must_be_equal_to_or_higher_than_update_interval
    machine_update_interval = Machine.find(self.machine_id).update_interval
    if self.duration.nil? || self.duration < machine_update_interval
      errors.add(:duration, "must be equal to or greater than #{machine_update_interval}")
    end
  end

  def check_dj
    alert = self
    alert_id = id

    actable_id
    # actable_type = self.actable_type

    if actable_type.constantize.is_higher(actable_id)
      alert_email_trigger(alert_id)
    else
      alert_email_untrigger(alert_id)
    end

    delayed_job = alert.delay(run_at: alert.check_interval.minutes.from_now).check_dj

    alert.delayed_job_id = delayed_job.id
    alert.save
  end

  # private

  def init
    machine = Machine.find(machine_id)
    self.check_interval = machine.update_interval
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
