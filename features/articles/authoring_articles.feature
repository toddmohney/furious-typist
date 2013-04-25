Feature: Authoring Articles
  As an admin
  I want to create, edit, and delete articles
  So that I can control the content of the blog

  @javascript
  Scenario: Creating a new article
    Given I am logged in as an admin

    When I go to the "article creation" page

    Then I should see the article creation form

    When I fill out the article creation form
    And I click on the "Create Article" button

    Then I should see my article

  Scenario: Trying to create an aritcle without the required role
    Given I am not logged in

    When I go to the "article creation" page

    Then I should see the unauthorized message

    Given I am logged in as a non-admin

    When I go to the "article creation" page

    Then I should see the unauthorized message

  @javascript
  Scenario: Editing an existing article
    Given I am logged in as an admin
    And There is an existing published article

    When I go to the "edit article" page

    Then I should see the article edit form

    When I fill out the article edit form
    And I click on the "Update Article" button

    Then I should see my updated article

  # @javascript
  # Scenario: Deleting an existing article
    # Given I am logged in as an admin
    # And There is an existing published article

    # When I go to the "articles" page

    # Then I should see a link to delete the article

    # When I click to delete the article

    # Then I should no longer see the article
