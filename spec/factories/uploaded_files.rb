# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :uploaded_file do
    file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'testfiles', 'image1.png')) }
  end
end
