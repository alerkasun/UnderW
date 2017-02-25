class AddOriginalFilenameToUploadedFile < ActiveRecord::Migration
  def change
    add_column :uploaded_files, :original_filename, :string
  end
end
