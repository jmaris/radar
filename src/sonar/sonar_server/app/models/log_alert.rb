class LogAlert < ActiveRecord::Base
  acts_as       :alert

  validates     :check_interval, presence: true, numericality: { only_integer: true }, inclusion: { in: 1..1440 }
  validates     :logger_type, presence: true, inclusion: { in: ['custom', 'systemd'] }
  validates     :path, presence: true # validate the path actually exists
  validates		:arguments, presence: true # [RegEx format]

  private

  def self.is_higher(log_alert_id)
  	machine       = Machine.find(Alert.where(actable_type: "StorageAlert", actable_id: storage_alert_id).first.machine_id)
  	log_alert = StorageAlert.find(log_alert_id)

    log_path  = 'logs/'
    log_path  << ERB::Util.url_encode(storage_alert.logger_type)
    log_path  << '/'
    log_path  << ERB::Util.url_encode(storage_alert.path)
    log_path  << '/'
    log_path  << ERB::Util.url_encode('/')
    log_path  << ERB::Util.url_encode(storage_alert.arguments)
    log_path  << ERB::Util.url_encode('/')
   	log_api   = Machine.api(machine.protocol,machine.host,machine.port,log_path)
   	
  	false
  end
end
