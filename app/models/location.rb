class Location < ActiveRecord::Base
  belongs_to :device

  validates_presence_of :latitude, :longitude, :time

  def to_s
    "#{id}: #{latitude} #{longitude} #{time}"
  end

  scope :date_from, -> (date) {
    where("time >= ?", Date.strptime(date, "%Y-%m-%d"))
  }

  scope :date_to, -> (date) {
    where("time <= ?", Date.strptime(date, "%Y-%m-%d") + 1.days)
  }

  scope :sort, -> (direction) {
    if direction.upcase == "ASC"
      order(time: :asc)
    else
      order(time: :desc)
    end
  }

  scope :accuracy_better_than, -> (accuracy) {
    where("accuracy < ?", accuracy)
  }

  def self.latest
    order(time: :desc).first
  end


  def self.filter(filter_params)
    locations = self.where(nil)
    filter_params.each do |key, value|
      locations = locations.public_send(key, value) if value.present? && !value.empty?
    end
    locations
  end

end
