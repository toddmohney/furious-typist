Given /^I am logged out$/ do
  log_me_out
end

When /^I go to the "(.*?)" page$/ do |page|
  visit path_to(page)
end

Then /^I should be redirected to the login page$/ do
  page.should have_content "Sign in"
  page.should have_content "You need to sign in or sign up before continuing."
end

When /^I go to my "(.*?)" page$/ do |page|
  visit path_to(page)
end

When /^I click on the "(.*?)" button$/ do |click_tgt|
  click_button(click_tgt)
end

Then /^I should be on the "([^"]*)"( [\w]*)? page$/ do |page_name, format|
  start = Time.now
  while true
    current_path = URI.parse(current_url).select(:path, :query).compact.join('?')
    expected_path = path_to(page_name)
    if format.present?
      expected_path = expected_path << ".#{format.gsub(" ", "")}"
    end
    break if current_path == expected_path
    if Time.now > start + 1.seconds
      fail "Expected to be at #{expected_path}, but actually at #{current_path}"
    end
    sleep 0.1
  end
end

module StepHelpers
  def current_path
    URI.parse(current_url).path
  end

  def path_to(page)
    case page.downcase
    when "articles"
      articles_path
    when "article creation"
      new_article_path
    when "edit article"
      edit_article_path(@article)
    when "sign in"
      new_user_session_path
    when "sign out"
      destroy_user_session_path
    when "users"
      users_path
    when "user profile"
      user_path(@user)
    when "edit profile"
      edit_user_path(@user)
    else
      "Page route not defined. (helper_steps.rb)"
    end

  end
end

module AuthenticationHelpers
  def log_me_in(user=nil)
    if user.blank?
      user = FactoryGirl.create(:user)
    end

    visit '/users/sign_in'
    fill_in "user_email", :with => user.email
    fill_in "user_password", :with => user.password
    click_button "Sign in"

    # the user has now been redirected to the home page
    raise "Failed to log in" unless page.has_selector?(".username")

    user
  end

  def log_me_in_as_admin(user=nil)
    user = log_me_in(user)
    user.add_role(Role.admin)
    user
  end

  def log_me_out
    unless @user.blank?
      visit path_to("sign out")
    end
  end
end

World(AuthenticationHelpers)
World(StepHelpers)
