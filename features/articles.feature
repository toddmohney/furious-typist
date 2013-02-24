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

    # TODO: test negative path with invalid input
    
    # Testing positive path
    When I fill out the article creation form
    And I click on the "Create Article" button
    Then I should see my article

  @javascript
  Scenario: Editing an existing article
    Given I am logged in
    And There is an existing article

    When I go to the "edit article" page
    Then I should see the article edit form

    # TODO: test negative path with invalid input

    # Testing positive path
    When I fill out the article edit form
    And I click on the "Update Article" button 
    Then I should see my updated article
