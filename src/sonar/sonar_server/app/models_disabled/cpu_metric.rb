class CpuMetric < Metric
# Attributes: CPU
    has_one :companion, class_name: "CpuMetricCompanion", inverse_of: :cpu_metric, dependent: :destroy, autosave: true

    delegate :cpu, :cpu=, to: :lazily_built_companion
    # delegate :cpu, :cpu=, :load_average_1min, :load_average_1min=, :load_average_5min, :load_average_5min=, :load_average_15min, :load_average_15min=, to: :lazily_built_companion

    validates :cpu, presence: true, numericality: true
    # validates :load_average_1min, presence: true, numericality: true
    # validates :load_average_5min, presence: true, numericality: true
    # validates :load_average_15min, presence: true, numericality: true

    private
    def lazily_built_companion
        companion || build_companion
    end
end