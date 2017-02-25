class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :key
      t.string :name
      t.integer :user_id

      t.timestamps
    end
    add_index :devices, :key, unique: true
  end
end
