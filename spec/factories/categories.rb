FactoryGirl.define do
  factory :category do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
  end 
end
