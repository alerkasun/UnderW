ActiveAdmin.register Device do
  index do
    column :id do |device|
      link_to device.id, [:admin, device]
    end
    column :name
    column :user
    column :key do |device|
      device.key.truncate(20)
    end
    column :created_at
    column :updated_at
    actions
  end

  member_action :send_gcm, method: :put do
    SendGcmMessageJob.perform_later resource.id
    redirect_to resource_path, notice: "GCM Message sent"
  end

  action_item :send_gcm, only: :show do
    link_to "Send GCM", send_gcm_admin_device_path(resource), method: :put
  end

end