class CpuAlert < ActiveRecord::Base
  acts_as:alert

  validates :threshold, presence: true, numericality: true, inclusion: { in: 0..100 }

  private

  def self.is_higher(cpu_alert_id)
    machine   = Machine.find(Alert.where(actable_type: "CpuAlert", actable_id: cpu_alert_id).first.machine_id)

    # live_cpu = CpuMetric.where(machine_id: 4).last.cpu
    cpu_alert = CpuAlert.find(cpu_alert_id)
    threshold = cpu_alert.threshold

    cycles = cpu_alert.duration / cpu_alert.check_interval

    for i in 0..(cycles - 1)
      if CpuMetric.where(machine_id: machine.id).last(cycles)[i].cpu < threshold
        return false
      end
      if i == (cycles - 1)
        return true
      end
    end
  end
end
