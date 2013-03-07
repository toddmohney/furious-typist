Feature: Articles
  Scenario: Viewing a list of articles
    Given There is a published article
    And I am not logged in

    When I go to the "articles" page
    Then I should see a list of published articles
    And I should not see a link to create a new article
    And I should not see a link to edit an existing article

  @javascript
  Scenario: Creating a new article
    Given I am logged in as an admin

    When I go to the "article creation" page
    Then I should see the article creation form

    # Testing positive path
    When I fill out the article creation form
    And I click on the "Create Article" button
    Then I should see my article

  @javascript
  Scenario: Editing an existing article
    Given I am logged in as an admin
    And There is an existing article

    When I go to the "edit article" page
    Then I should see the article edit form

    # Testing positive path
    When I fill out the article edit form
    And I click on the "Update Article" button
    Then I should see my updated article

  @javascript
  Scenario: Deleting an existing article
    Given I am logged in as an admin
    And There is an existing article

    When I go to the "articles" page
    Then I should see a link to delete the article

    # THE FOLLOWING TEST IS INCOMPATIBLE WITH PHANTOMJS
    # PHANTOMJS ALWAYS RETURNS true FROM A CONFIRM BOX
    #
    # When I click to delete the article
    # And I click to cancel the deletion of the article
    # Then The article should not be deleted

    When I click to delete the article
    # And I click to confirm the deletion of the article
    Then I should no longer see the article

  Scenario: Trying to create an aritcle without the required role
    Given I am not logged in
    When I go to the "article creation" page
    Then I should see the unauthorized message

    Given I am logged in as a non-admin
    When I go to the "article creation" page
    Then I should see the unauthorized message
