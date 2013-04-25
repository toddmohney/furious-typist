Feature: Viewing articles
  As a user
  I want to view articles
  So that I can read the authors' content

  Scenario: Viewing a list of articles
    Given I am not logged in
    And there is a published article

    When I go to the "articles" page
    Then I should see a list of published articles
    And I should not see a link to create a new article
    And I should not see a link to edit an existing article

  Scenario: Viewing a published article
    Given I am not logged in
    And there is a published article

    When I go to the "articles" page
    And I click on the title of the article

    Then I should see the article

  Scenario: Viewing an unpublished article as an anonymous user
    Given I am not logged in
    And there is an unpublished article

    When I try to go directly to the unpublished article page

    Then I should be redirected to the unauthorized page

  Scenario: Viewing an unpublished article as a user
    Given I logged in as a user
    And there is an unpublished article

    When I try to go directly to the unpublished article page

    Then I should be redirected to the unauthorized page

  Scenario: Viewing an unpublished article as a user
    Given I logged in as a admin
    And there is an unpublished article

    When I go to the unpublished article page

    Then I should see the article
    And I should see an unpublished article notice
