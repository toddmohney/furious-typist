FactoryGirl.define do
  factory :article do
    body { Faker::Lorem.paragraphs(5) }
    title { Faker::Lorem.sentence }
    url { Faker::Internet.domain_name }
    category { FactoryGirl.create(:category) }
    tags {[ FactoryGirl.create(:tag), FactoryGirl.create(:tag), FactoryGirl.create(:tag) ]}
  end 

  factory :article_post_params, parent: :article do
    body { Faker::Lorem.paragraphs(5) }
    title { Faker::Lorem.sentence }
    url { Faker::Internet.domain_name }
    category "tech" 
    tags "ok,hi,nope,bye" 
  end
end
