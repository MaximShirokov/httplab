require 'factory_girl'

FactoryGirl.define do
  factory :message do
    text Faker::Lorem.sentence
    user
  end
end
