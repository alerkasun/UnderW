# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    latitude "47.073542"
    longitude "15.437714"
    altitude 400.5
    accuracy 1.5
    provider "GPS"
    time  "2014-11-15 13:40:27 +0100"
  end
end
