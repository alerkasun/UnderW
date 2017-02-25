ActiveAdmin.register Message do
  permit_params :text, :device_id
end