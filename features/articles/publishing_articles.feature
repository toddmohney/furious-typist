Feature: Publishing Articles
  As an admin
  I want to publish and unpublish
  So that I can control the visibility of the blog posts 

  @javascript
  Scenario: Publishing an article
    Given I am logged in as an admin
    And there is an unpublished article

    When I visit the article edit page
    And I publish the article

    Then I should see that the article has been published
    And I should see the article appear on the articles index page

  @javascript
  Scenario: Unpublishing an article
    Given I am logged in as an admin
    And there is a published article

    When I visit the article edit page
    And I unpublish the article

    Then I should see that the article has been unpublished
    And I should not see the article appear on the articles index page
