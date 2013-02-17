Then /^I should see a list of registered users$/ do
  page.should have_selector(".all_users")
end

Given /^There is a registered user$/ do
  @user = FactoryGirl.create(:user)
end

When /^I click on the user's name$/ do
  click_on @user.username 
end

Then /^I should see my user details$/ do
  page.find('.username').text.should == @user.username
  page.find('.email').text.should == @user.email
end
