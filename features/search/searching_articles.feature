# Feature: Searching articles
  # As a user
  # I want to see a list of articles related to search terms
  # So that I can find the specific content that I am looking 
    # for without paging through the entire blog

  # @search
  # Scenario: Searching for an article by title
    # Given I am a visitor
    # And there is an article titled "tuna talk"

    # When I am on the "search" page
    # And I search for "tuna talk"

    # Then I should see the article titled "tuna talk" in the search results

  # @search
  # Scenario: Searching for an article by content
    # Given I am a visitor
    # And there is an article with the word "babaganoush" in its body

    # When I am on the "articles" page
    # And I search for "babaganoush"

    # Then I should see the article with the content "babaganoush" in the search results

  # @search
  # Scenario: Searching for articles by category
    # Given I am a visitor
    # And there are 2 articles in the category "goodtimes"

    # When I am on the "articles" page
    # And I search for "goodtimes"

    # Then I should see all articles in the category "goodtimes" in the search results

  # @search
  # Scenario: Searching for articles by tag
    # Given I am a visitor
    # And there are 2 articles with the tag "burgers"

    # When I am on the "articles" page
    # And I search for "burgers"

    # Then I should see all articles with the tag "burgers" in the search results
