Given /^I am logged out$/ do
#  unless session_user.blank?
#    visit path_to("sign out")
#  end
end

When /^I go to the "(.*?)" page$/ do |page|
  visit path_to(page)
end


When /^I go to my "(.*?)" page$/ do |page|
  visit path_to(page)
end

module StepHelpers
  def current_path
    URI.parse(current_url).path
  end

  def path_to(page)
    case page.downcase
    when "articles"
      articles_path
    when "sign in"
      new_user_session_path
    when "sign out"
      destroy_user_session_path
    when "users"
      users_path
    when "user profile"
      user_path(@user)
    else
      "Page route not defined. (helper_steps.rb)"
    end

  end
end
World(StepHelpers)
