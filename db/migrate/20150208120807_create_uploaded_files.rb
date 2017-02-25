class CreateUploadedFiles < ActiveRecord::Migration
  def change
    create_table :uploaded_files do |t|
      t.string :file
      t.references :device, index: true

      t.timestamps null: false
    end
    add_foreign_key :uploaded_files, :devices
  end
end
