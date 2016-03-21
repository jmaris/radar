class LogAlert < ActiveRecord::Base
  acts_as       :alert

  private

  def self.is_higher(log_alert_id)
  	false
  end
end
