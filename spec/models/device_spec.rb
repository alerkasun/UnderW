require 'rails_helper'

describe Device do
  it "is invalid without a name" do
    device = Device.new(name: nil)
    expect(device.valid?).to be false
    expect(device).to have(1).errors
  end
  it "automatically generates a key before create" do
    device = Device.create(name: Faker::Hacker.noun)
    expect(device.key).not_to be_blank
  end
end
