class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  has_many :devices, :dependent => :destroy
  #has_many :invitations, :class_name => "User", :as => :invited_by
  scope :admins, -> { where(admin: true) }
end
