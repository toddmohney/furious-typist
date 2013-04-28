FactoryGirl.define do
  factory :role do
    name "some_role"
  end

  factory :admin_role, class: Role do
    name "admin"
  end

  factory :user_role, parent: :role do
    name "user"
  end
end
