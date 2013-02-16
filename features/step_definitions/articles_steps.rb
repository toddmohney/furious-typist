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

Then /^I should not see a link to create a new article$/ do
  page.should_not have_selector ".new-article"
end

Given /^I am an authenticated user$/ do
  password = Faker::Name.name
  @user = User.new(:email => Faker::Internet.email,
                     :username => Faker::Name.name,
                     :password => password,
                     :password_confirmation => password)  
  @user.save!
  @user.activate!
end

Then /^I should see a link to create a new article$/ do
  page.should have_selector ".new-article"
end

