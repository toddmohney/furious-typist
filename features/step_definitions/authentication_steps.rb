Given /^I am not authenticated$/ do
  # visit '/users/sign_out'
  # reset_session
end

When /^I go to register$/ do
  visit '/users/sign_up'
end

When /^I fill in "(.*?)" with "(.*?)"$/ do |arg1, arg2|
  fill_in arg1, :with => arg2
end

When /^I press "(.*?)"$/ do |btn|
  click_button btn
end

Then /^I should see "(.*?)"$/ do |arg1|
  page.should have_selector(arg1)
end

Then /^I should be redirected to the "(.*?)" page$/ do |page_name|
  case page_name.downcase
  when "home"
    current_path == "/"
  when "articles"
    current_path == "/articles"
  else
    raise "No path defined for #{page_name}"
  end
end

Then /^I should see the element "(.*?)"$/ do |tag_name|
  page.should have_selector(".#{tag_name}")
end

Given /^I have an existing account$/ do
  @user = FactoryGirl.create(:user)
end

When /^I go to login$/ do
  visit '/users/sign_in'
end

When /^I fill in the login form$/ do
  fill_in "user_email", :with => @user.email
  fill_in "user_password", :with => @user.password
end

Given /^I am logged in$/ do
  @user = log_me_in
end

Then /^I should not see the element "(.*?)"$/ do |tag_name|
  page.should_not have_selector(".#{tag_name}")
end

When /^I click "(.*?)"$/ do |text|
  click_link text
end

Given /^I logged in as a user$/ do
  @user = log_me_in
end

Given /^I logged in as a admin$/ do
  @user = log_me_in_as_admin
end

Given /^I am an admin$/ do
  @user = log_me_in_as_admin
end

Given /^there is a non\-admin user$/ do
  @other_user = FactoryGirl.create(:user)
end

