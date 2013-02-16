FactoryGirl.define do
  factory :user do
    username Faker::Name.name
    email Faker::Internet.email
    password "12345abcdefg"
    password_confirmation "12345abcdefg"
  end 
end
