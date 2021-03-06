FactoryGirl.define do
  factory :user do
    username { Faker::Name.first_name }
    email { Faker::Internet.email }
    password "12345abcdefg"
    password_confirmation "12345abcdefg"
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    roles {[ Role.user ]}
  end

  factory :admin, parent: :user do
    roles {[ Role.user, Role.admin ]}
  end
end
