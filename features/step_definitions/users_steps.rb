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
  page.find('.email').text.should == @user.email
end

Then /^I should be able to edit the first and last name fields$/ do
  fill_in('First name', :with => "todd")
  fill_in('Last name', :with => "mohney")

  click_button('Update User')
 
  # we should be redirected back to the user 
  # profile page 
  page.find('.first-name').text.should == "todd"
  page.find('.last-name').text.should == "mohney"
end

Then /^I should not be able to edit the username field$/ do
  page.find_by_id('user_username')[:readonly].should == "readonly"
end

Then /^I should not be able to edit the email field$/ do
  page.find_by_id('user_email')[:readonly].should == "readonly"
end

Then /^I should not be able to edit the email validated field$/ do
  page.find_by_id('user_is_email_validated')[:disabled].should == "disabled"
end
