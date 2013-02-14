Given /^I am an unauthenticated user$/ do
  @user = nil 
end

When /^I am on the "(.*?)" page$/ do |page_name|
  page_name.downcase!

  case page_name
  when 'articles'
    visit '/articles'
  end
end

Then /^I should see a list of published articles$/ do
  page.should have_selector ".article-container"
end
