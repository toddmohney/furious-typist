Feature: Users
  Scenario: Viewing a list of registered users 
    When I go to the "users" page
    Then I should see a list of registered users


  Scenario: Viewing a user profile page
    Given There is a registered user
    
    When I go to the "users" page
    And I click on the user's name

    Then I should see my user details

  Scenario: Editing a user profile
    Given There is a registered user

    When I go to the "edit profile" page

    Then I should not be able to edit the username field
    And I should not be able to edit the email field
    And I should not be able to edit the email validated field
    But I should be able to edit the first and last name fields

