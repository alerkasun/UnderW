class CreatePendingcommands < ActiveRecord::Migration
  def change
    create_table :pendingcommands do |t|
      t.references :device, index: true
      t.string :command
      t.datetime :completed_at

      t.timestamps
    end
  end
end
