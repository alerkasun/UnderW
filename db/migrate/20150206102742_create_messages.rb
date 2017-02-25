class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :device, index: true
      t.text :text

      t.timestamps null: false
    end
    add_foreign_key :messages, :devices
  end
end
