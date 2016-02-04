class RamMetric < Metric
# Attributes: RAM, swap
    has_one :companion, class_name: "RamMetricCompanion", inverse_of: :ram_metric, dependent: :destroy, autosave: true

    delegate :ram, :ram=, to: :lazily_built_companion
    # delegate :ram, :ram=, :swap, :swap=, to: :lazily_built_companion

    # validates :ram, presence: true, numericality: true
    # validates :swap, presence: true, numericality: true

    private
    def lazily_built_companion
        companion || build_companion
    end
end
