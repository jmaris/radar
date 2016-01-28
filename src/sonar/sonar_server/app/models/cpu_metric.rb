class CpuMetric < Metric
# Attributes: CPU
    has_one :companion, class_name: "CpuMetricCompanion", inverse_of: :cpu_metric, dependent: :destroy, autosave: true

    delegate :cpu, :cpu=, to: :lazily_built_companion
    validates :cpu, presence: true

    private
    def lazily_built_companion
        companion || build_companion
    end
end