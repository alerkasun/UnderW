class Device < ActiveRecord::Base
  before_create :generate_key
  belongs_to :user
  has_many :locations, :dependent => :destroy
  has_many :pendingcommands, :dependent => :destroy
  has_many :messages, :dependent => :destroy
  has_many :uploaded_files, :dependent => :destroy

  validates_presence_of :name

  def to_json
    Jbuilder.encode do |json|
      json.base_url Settings.host_config.base_url
      json.base_url_port Settings.host_config.ssl_port
      json.device_key self.key
    end
  end

private

  def generate_key
    begin
      self.key = SecureRandom.hex(32)
    end while self.class.exists?(key: key)
  end
end
