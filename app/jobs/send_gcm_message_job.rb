class SendGcmMessageJob < ActiveJob::Base
  queue_as :default

  def perform(device_id)
    return if Settings["gcm_config"].nil? || Settings["gcm_config"]["api_key"].nil? || Settings["gcm_config"]["api_key"].empty?
    device = Device.find(device_id)
    return if device.nil? || device.gcm_regid.nil? || device.gcm_regid.empty?
    gcm = GCM.new(Settings["gcm_config"]["api_key"])
    options = {collapse_key: "pull-commands"}
    ids = [device.gcm_regid]
    response = gcm.send(ids, options)
  end
end
