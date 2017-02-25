ActiveAdmin.register UploadedFile do

  index do
    selectable_column
    column :id do |f|
      link_to f.id, [:admin, f]
    end
    column :device
    column :user
    column :created_at
    column :original_filename
    column :content_type
    column :file_size do |f|
      number_to_human_size(f.file_size)
    end
    actions do |f|
      link_to "Download", device_uploaded_file_path(f.device, f)
    end

  end
end