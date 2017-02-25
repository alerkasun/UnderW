class Pendingcommand < ActiveRecord::Base
  belongs_to :device
  has_one :user, through: :device

  scope :unfinished, -> { where(completed_at: nil) }
  scope :finished, -> { where.not(completed_at: nil) }
end
