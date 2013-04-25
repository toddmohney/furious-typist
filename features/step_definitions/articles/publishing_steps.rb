Given /^there is an unpublished article$/ do
  @article = FactoryGirl.create(:unpublished_article)
end

When /^I visit the article edit page$/ do
  visit edit_article_path @article
  page.should have_content "Editing article"
end

When /^I publish the article$/ do
  check "Published"
  click_on "Update Article"
end

Then /^I should see that the article has been published$/ do
  page.should have_content("Article was successfully updated")
  page.should have_content("You are viewing a published article")
end

Then /^I should see the article appear on the articles index page$/ do
  visit articles_path
  page.should have_content @article.title
end

Given /^there is a published article$/ do
  @article = FactoryGirl.create(:published_article)
end

When /^I unpublish the article$/ do
  uncheck "Published"
  click_on "Update Article"
end

Then /^I should see that the article has been unpublished$/ do
  page.should have_content("Article was successfully updated")
  page.should have_content("You are viewing this article in preview mode. This article has not been published")
end

Then /^I should not see the article appear on the articles index page$/ do
  visit articles_path
  page.should have_no_content @article.title
end
