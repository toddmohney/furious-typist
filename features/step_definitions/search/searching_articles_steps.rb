Given /^I am a visitor$/ do
  # nothing to be done.
  # this step is for articulating clear steps
end

Given /^there is an article titled "(.*?)"$/ do |title|
  @article = FactoryGirl.create(:published_article, title: title)
  Article.index
end

When /^I search for "(.*?)"$/ do |search_term|
  page.should have_selector ".search-container"

  fill_in "search_box", with: search_term

  click_on "Search"
end

Then /^I should see the article titled "(.*?)" in the search results$/ do |title|
  within ".search-results" do
    page.should have_content(title)
  end
end

Given /^there is an article with the word "(.*?)" in its body$/ do |search_term|
  body = Faker::Lorem.paragraphs(1) + " #{search_term}"
  @article = FactoryGirl.create(:published_article, body: body)
end

Then /^I should see the article with the content "(.*?)" in the search results$/ do |search_term|
  within ".search-results" do
    page.should have_content(@article.title)
  end
end

Given /^there are (\d+) articles in the category "(.*?)"$/ do |count, category_name|
  @articles = []
  count.to_i.times do
    category = FactoryGirl.create(:category, name: category_name)
    @articles << FactoryGirl.create(:published_article, category: category)
  end
end

Then /^I should see all articles in the category "(.*?)" in the search results$/ do |category_name|
  within ".search-results" do
    page.should have_selector(".result", count: @articles.count)
  end
end

Given /^there are (\d+) articles with the tag "(.*?)"$/ do |count, tag_name|
  count.to_i.times do
    tag = FactoryGirl.create(:tag, name: tag_name)
    @articles ||= FactoryGirl.create(:published_article, tags: [ tag ])
  end
end

Then /^I should see all articles with the tag "(.*?)" in the search results$/ do |tag_name|
  within ".search-results" do
    page.should have_selector(".result", count: @articles.count)
  end
end
