Feature: Articles
  Scenario: Viewing a list of articles as an unauthenticated user
    Given I am an unauthenticated user

    When I am on the "Articles" page
    Then I should see a list of published articles
    And I should not see a link to create a new article

  Scenario: Viewing a list of articles as an authenticated user
    Given I am an authenticated user

    When I am on the "Articles" page
    Then I should see a list of published articles
    And I should see a link to create a new article
