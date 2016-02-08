class RamMetric < ActiveRecord::Base
    belongs_to :machine, dependent: :delete
    validates_associated :machine

    validates :ram, presence: true, numericality: true
    # validates :swap, presence: true, numericality: true #swap is not yet available
    validates :machine_id, presence: true, numericality: { only_integer: true }
    validate :machine

private

    def machine
        errors.add(:machine_id, "is invalid") unless Machine.exists?(self.machine_id)
    end
end
