class UploadedFile < ActiveRecord::Base
  belongs_to :device
  has_one :user, through: :device
  validates_presence_of :device, :file
  mount_uploader :file, FileUploader

  def filename
    file.file.filename
  end

  def content_type
    file.content_type
  end

  def file_size
    file.size
  end

end
