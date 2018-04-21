FactoryGirl.define do
  factory :user do
    sequence(:email) { |s| "user#{s}@mail.com" }
    password 'password'
  end
end
