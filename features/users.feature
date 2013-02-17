Feature: Users
  Scenario: Viewing a list of registered users 
    When I go to the "users" page
    Then I should see a list of registered users


  Scenario: Viewing a user profile page
    Given There is a registered user
    
    When I go to the "users" page
    And I click on the user's name

    Then I should see my user details
