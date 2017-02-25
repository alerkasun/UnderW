# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :certificate do
    subject "MyString"
    issuer "MyString"
    valid_until "2014-11-09"
    subject_alt_names "MyString"
    default false
  end
end
