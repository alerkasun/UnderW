class RemoveInvitedByTypeFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :invited_by_type
  end
end
