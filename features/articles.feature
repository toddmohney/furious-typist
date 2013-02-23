Feature: Articles
  Scenario: Viewing a list of articles
    Given There is a published article

    When I go to the "articles" page
    Then I should see a list of published articles
    And I should not see a link to create a new article

  @javascript
  Scenario: Creating a new article
    Given I am logged in

    When I go to the "article creation" page
    Then I should see the article creation form

    When I fill out the article creation form
    And I submit the form
    And I should see my article
