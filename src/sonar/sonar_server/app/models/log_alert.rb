class LogAlert < ActiveRecord::Base
  acts_as       :alert

  validates     :check_interval, presence: true, numericality: { only_integer: true }, inclusion: { in: 1..1440 }
  validates     :logger_type, presence: true, inclusion: { in: ['custom', 'systemd'] }
  validates     :path, presence: true # validate the path actually exists
  validates     :arguments, presence: true # [RegEx format]
  validate

  after_create  :init # sets triggered to false

  def init
    machine           = Machine.find(self.machine_id)
    log_alert         = self
    log_path          = 'logs/'
    log_path          << ERB::Util.url_encode(log_alert.logger_type)
    log_path          << '/'
    log_path          << ERB::Util.url_encode(log_alert.path)
    log_path          << '/'
    log_path          << ERB::Util.url_encode(log_alert.arguments)
    log_api           = Machine.api(machine.protocol,machine.host,machine.port,log_path)
    self.triggered    = false
    self.match_amount = log_api[:match][:amount]
    self.save
    self.check_dj
  end

  private

  def self.is_higher(log_alert_id)
    machine   = Machine.find(Alert.where(actable_type: "LogAlert", actable_id: log_alert_id).first.machine_id)
    log_alert = LogAlert.find(log_alert_id)

    log_path  = 'logs/'
    log_path  << ERB::Util.url_encode(log_alert.logger_type)
    log_path  << '/'
    log_path  << ERB::Util.url_encode(log_alert.path)
    log_path  << '/'
    log_path  << ERB::Util.url_encode(log_alert.arguments)
    log_api   = Machine.api(machine.protocol,machine.host,machine.port,log_path)
    
    # byebug

    if log_alert.match_amount < log_api[:match][:amount]
      true
    elsif log_alert.match_amount > log_api[:match][:amount]
      logger.debug "showing log_alert"
      logger.debug log_alert
      logger.debug "showing the API"
      logger.debug log_api[:match][:amount]
      logger.debug "API returned less matches than we have on file.
      This is probably because the log has rotated.
      Rotating logs is not supported yet."
      false
    end
  end
end