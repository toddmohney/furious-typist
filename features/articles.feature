Feature: Articles
  Scenario: Viewing a list of articles as an unauthenticated user
    Given I am logged out
    And There is a published article
    When I go to the "articles" page
    Then I should see a list of published articles
    And I should not see a link to create a new article

  Scenario: Viewing a list of articles as an authenticated user
    Given I am logged in
    And There is a published article
    When I go to the "articles" page
    Then I should see a list of published articles
    And I should see a link to create a new article
