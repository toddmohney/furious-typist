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
    page.fill_in "article_title", :with => Faker::Lorem.words(5).join(" ")
    page.fill_in "article_body", :with => Faker::Lorem.paragraphs(5).join(" ")
    page.fill_in "article_category", :with => Faker::Lorem.word
    page.fill_in "article_tags", :with => Faker::Lorem.words(5).join(" ")
  end
end

Then /^I should see my article$/ do
  page.should have_content("Article was successfully created.")
end

Given /^There is an existing published article$/ do
  @article ||= FactoryGirl.create(:published_article)
end

Then /^I should see the article edit form$/ do
  page.should have_content("Editing article")
end

When /^I fill out the article edit form$/ do
  @edited_article = FactoryGirl.build(:article)

  # ensure the factory built, but did not create
  # a new article
  Article.all.count.should eq(1)

  page.fill_in "article_title", :with => @edited_article.title
  page.fill_in "article_body", :with => @edited_article.body.join
end

Then /^I should see my updated article$/ do
  page.should have_content("Article was successfully updated.")

  page.should have_content(@edited_article.title)
  page.should have_content(@edited_article.body.join)
end

Given /^I am not logged in$/ do
  log_me_out
end

Then /^I should not see a link to edit an existing article$/ do
  page.should have_no_selector(".admin-article")
end

Given /^I am logged in as an admin$/ do
  @user = log_me_in_as_admin
end

Then /^I should see a link to delete the article$/ do
  within '.admin-article' do
    page.should have_content('Destroy')
  end
end

When /^I click to delete the article$/ do
  within '.admin-article' do
    click_on 'Destroy'
  end
end

When /^I click to cancel the deletion of the article$/ do
  page.driver.browser.switch_to.alert.dismiss
end

Then /^The article should not be deleted$/ do
  page.should have_content(@article.title)
end

When /^I click to confirm the deletion of the article$/ do
  page.driver.browser.switch_to.alert.accept
end

Then /^I should no longer see the article$/ do
  page.should have_no_content(@article.title)
end

Then /^I should be redirected to the sign in page$/ do
  page.current_path.should eq("/users/sign_in")
end

Given /^I am logged in as a non\-admin$/ do
  @user = log_me_in
end

When /^I click on the title of the article$/ do
  click_on @article.title
  page.should have_no_selector(".article-container")
end

Then /^I should see the article$/ do
  # page.should have_content(@article.title)
  page.should have_content("this doesn't exist")
end

When /^I try to go directly to the unpublished article page$/ do
  visit article_path @article
end

Then /^I should be redirected to the unauthorized page$/ do
  page.should have_content "Go skate somewhere else"
end

When /^I go to the unpublished article page$/ do
  visit article_path @article
end

Then /^I should see an unpublished article notice$/ do
  page.should have_content("You are viewing this article in preview mode. This article has not been published")
end
