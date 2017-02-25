# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pendingcommand do
    device
    command "dummy command"

    factory :completedcommand do
      completed_at "2015-01-28 12:16:44"
    end
  end
end
