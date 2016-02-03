class RamMetricCompanion < ActiveRecord::Base
    belongs_to :ram_metric, inverse_of: :companion
    validates :ram_metric, presence: true
end
