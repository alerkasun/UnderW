
json.name @device.name
if @device.locations.last
	json.last_location @device.locations.last.time
end
if Settings["gcm_config"] && Settings["gcm_config"]["project_number"]
	json.gcm do
		json.sender_id Settings["gcm_config"]["project_number"]
		json.reg_id @device.gcm_regid
	end
end