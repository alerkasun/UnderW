class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :device_id
      t.decimal :latitude, :precision => 10, :scale => 7
      t.decimal :longitude, :precision => 10, :scale => 7
      t.float :altitude
      t.float :accuracy
      t.string :provider
      t.datetime :time

      t.timestamps
    end
  end
end
