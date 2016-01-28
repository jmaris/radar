class CpuMetricCompanion < ActiveRecord::Base
    belongs_to :cpu_metric, inverse_of: :companion
    validates :cpu_metric, presence: true
end
