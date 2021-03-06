FactoryGirl.define do
  factory :article do
    body { Faker::Lorem.paragraphs(5) }
    title { Faker::Lorem.sentence }
    category { FactoryGirl.create(:category) }
    tags {[ FactoryGirl.create(:tag) ]}
  end

  factory :article_with_author, parent: :article do
    author { FactoryGirl.create(:admin) }
  end

  factory :unpublished_article, parent: :article_with_author do
    published false
  end

  factory :published_article, parent: :article_with_author do
    published true
  end

  factory :article_post_params, parent: :article do
    body { Faker::Lorem.paragraphs(5) }
    title { Faker::Lorem.sentence }
    category "tech"
    tags "ok,hi,nope,bye"
  end
end
