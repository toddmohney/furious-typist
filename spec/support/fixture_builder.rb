FixtureBuilder.configure do |fbuilder|
  # rebuild fixtures automatically when these files change:
  fbuilder.files_to_check += Dir["spec/factories/*.rb", "spec/support/fixture_builder.rb"]

  fbuilder.factory do
    fbuilder.name(:user, FactoryGirl.create(:user))
    fbuilder.name(:non_admin, FactoryGirl.create(:user))
    fbuilder.name(:admin, FactoryGirl.create(:admin))

    fbuilder.name(:article, FactoryGirl.create(:article))
    fbuilder.name(:unpublished_article, FactoryGirl.create(:unpublished_article))
    fbuilder.name(:published_article, FactoryGirl.create(:published_article))

    fbuilder.name(:role, FactoryGirl.create(:role))
    fbuilder.name(:admin_role, FactoryGirl.create(:admin_role))
    fbuilder.name(:user_role, FactoryGirl.create(:user_role))
  end
end
