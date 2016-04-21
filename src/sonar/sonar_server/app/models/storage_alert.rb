class StorageAlert < ActiveRecord::Base

  acts_as :alert # inheritance with gem 'active_record-acts_as'

  validates       :threshold, presence: true, numericality: true, inclusion: {in: 0..100}
  validates       :path, presence: true

  after_create  :init # sets triggered to false

  def init    self.triggered = false
    self.save
    self.check_dj
  end

  private

  def self.is_higher(storage_alert_id)
    machine       = Machine.find(Alert.where(actable_type: "StorageAlert", actable_id: storage_alert_id).first.machine_id)
    storage_alert = StorageAlert.find(storage_alert_id)

    storage_path  = 'storage/'
    storage_path  << ERB::Util.url_encode(storage_alert.path)
    storage_api   = Machine.api(machine.protocol,machine.host,machine.port,storage_path)

    blocks_used   = storage_api[:blocks] - storage_api[:blocks_free]
    live_storage  = (blocks_used*100)/storage_api[:blocks].to_f

    if live_storage > storage_alert.threshold
      true
    else
      false
    end
    
  end
end
