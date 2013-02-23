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
World(StepHelpers)
