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

