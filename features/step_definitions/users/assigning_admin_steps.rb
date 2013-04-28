Then /^I should see the admin role applied to their account$/ do
  user_element = page.find(".user", text: @other_user.username)
  user_element.should have_content("Roles: admin")
end

Then /^I should see the admin role as been removed from their account$/ do
  user_element = page.find(".user", text: @other_user.username)
  user_element.should have_no_content("Roles: admin")
end

When /^I click to edit the non\-admin user$/ do
  within(".user", text: @other_user.username) do 
    click_on "Edit"
  end

  page.should have_content "Editing user"
end

When /^I click to update the user$/ do
  click_on "Update User"

  page.should have_no_content "Editing user"
end

Then /^I should not see any buttons to edit the users$/ do
  within page.first(".user") do
    page.should have_no_content "Show"
    page.should have_no_content "Edit"
    page.should have_no_content "Destroy"
  end
end
