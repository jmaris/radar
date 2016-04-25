class RamAlert < ActiveRecord::Base
  acts_as       :alert

  validates     :threshold, presence: true, numericality: true, inclusion: { in: 0..100 }
  validates     :duration, presence: true, numericality: { only_integer: true }, inclusion: { in: 1..1440 }
  validate      :duration_must_be_equal_to_or_higher_than_update_interval

  after_create  :init # sets triggered to false

  def duration_must_be_equal_to_or_higher_than_update_interval
    machine                 = Machine.find(self.machine_id)
    if self.duration.nil? || self.duration < machine.update_interval
      errors.add(:duration, "must be equal to or greater than #{machine.update_interval}")
    end
  end

  def init
    machine_update_interval = Machine.find(self.machine_id).update_interval
    self.check_interval = machine_update_interval
    self.triggered = false
    self.save
    self.check_dj
  end

  private

  def self.is_higher(ram_alert_id)
    machine   = Machine.find(Alert.where(actable_type: "RamAlert", actable_id: ram_alert_id).first.machine_id)

    ram_alert = RamAlert.find(ram_alert_id)
    threshold = ram_alert.threshold

    cycles = ram_alert.duration / machine.update_interval

    for i in 0..(cycles - 1)
      if RamMetric.where(machine_id: machine.id).count < cycles || RamMetric.where(machine_id: machine.id).last(cycles)[i].ram < threshold
        return false
      end
      if i == (cycles - 1)
        return true
      end
    end
  end
end
