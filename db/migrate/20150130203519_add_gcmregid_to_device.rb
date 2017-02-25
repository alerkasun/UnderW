class AddGcmregidToDevice < ActiveRecord::Migration
  def change
    add_column :devices, :gcm_regid, :string
  end
end
