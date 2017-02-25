ActiveAdmin.register User do

  permit_params :email, :admin, :confirmed_at, :unconfirmed_email, :invitation_limit

  scope :admins

  filter :email
  filter :admin
  filter :confirmed_at
  filter :invitation_limit, label: 'Invitations Left'


  index do
    column :email do |user|
      link_to user.email, [:admin, user]
    end
    column :device_count do |user|
      user.devices.count
    end
    column "Invitations Left", :invitation_limit
    column :confirmed_at
    column :admin
    actions
  end

  show do
    attributes_table do
      row :id
      row :email
      row :admin
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :confirmed_at
      row :confirmation_sent_at
      row :unconfirmed_email
      row :created_at
      row :updated_at
      row :invitation_created_at
      row :invitation_sent_at
      row :invitation_accepted_at
      row ('Invitations Left') { |u| u.invitation_limit }
      row :invitations_count
      row :invited_by

    end
    active_admin_comments
  end

  form do |f|
    f.semantic_errors
    f.inputs "Details" do
      input :email
      input :confirmed_at
      input :unconfirmed_email
      input :invitation_limit, label: 'Invitations Left'
      input :admin
    end
    f.actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
