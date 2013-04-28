Feature: Users
  # Scenario: Viewing a list of registered users
    # Given I am logged in as an admin

    # When I go to the "users" page
    # Then I should see a list of registered users

  Scenario: Viewing a list of registered users without the proper role
    Given I am logged out
    When I go to the "users" page
    Then I should be redirected to the login page

    # Given I am logged in as a non-admin
    # When I go to the "users" page
    # Then I should see the unauthorized message

  Scenario: Viewing a user profile page
    Given I am logged in as an admin
    And There is a registered user

    When I go to the "users" page
    And I click on the user's name

    Then I should see my user details

  Scenario: Viewing a user profile page without the proper role
    Given I am logged in as a non-admin
    And There exists another registered user

    When I try to visit the other user's profile page
    Then I should see the unauthorized message

  Scenario: Editing a user profile
    Given I am logged in as an admin
    And There is a registered user

    When I go to the "edit profile" page

    Then I should not be able to edit the username field
    And I should not be able to edit the email field
    And I should not be able to edit the email validated field
    But I should be able to edit the first and last name fields


  Scenario: Editing a user profile page without the proper role
    Given I am logged in as a non-admin
    And There exists another registered user

    When I try to visit the other user's edit profile page
    Then I should see the unauthorized message
