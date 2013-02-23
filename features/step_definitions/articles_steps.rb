Given /^There is a published article$/ do
  FactoryGirl.create(:article)
end

Then /^I should see a list of published articles$/ do
  page.should have_selector(".article-container")
end

Then /^I should not see a link to create a new article$/ do
  page.should_not have_selector(".new-article")
end

Then /^I should see a link to create a new article$/ do
  page.should have_selector(".new-article")
end

Then /^I should see the article creation form$/ do
  page.should have_content("New article")
  page.should have_selector("#article_title")
  page.should have_selector("#article_body")
end

When /^I fill out the article creation form$/ do
  within("#new_article") do
    page.fill_in "article_url", :with => Faker::Internet.url
    page.fill_in "article_title", :with => Faker::Lorem.words(5).join(" ")
    page.fill_in "article_body", :with => Faker::Lorem.paragraphs(5).join(" ")
    page.fill_in "article_category", :with => Faker::Lorem.word
    page.fill_in "article_tags", :with => Faker::Lorem.words(5).join(" ")
  end
end

When /^I submit the form$/ do
  click_on "Create Article"
end

Then /^I should see my article$/ do
  page.should have_content("Article was successfully created.")
end
