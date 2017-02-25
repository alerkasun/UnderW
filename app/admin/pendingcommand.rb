ActiveAdmin.register Pendingcommand do
  permit_params :command, :completed_at, :device_id

  scope :all
  scope :unfinished
  scope :finished


  index do
    selectable_column
    column :id do |command|
      link_to command.id, [:admin, command]
    end
    column :device
    column :user
    column :command
    column :completed_at
    column :created_at
    column :updated_at
    actions
  end
end
