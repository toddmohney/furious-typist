Feature: Assigning a user as an admin
  As an admin user
  I want to assign admin access to other registered users
  So they may create articles and manage other users

  Scenario: Assigning an admin role to a user
    Given I am an admin
    And there is a non-admin user

    When I am on the "users" page
    And I click to edit the non-admin user
    And I check "Set as admin"
    And I click to update the user

    Then I should see the admin role applied to their account

  Scenario: Removing an admin role from a user
    Given I am an admin
    And there is another admin user

    When I am on the "users" page
    And I click to edit the non-admin user
    And I uncheck "Set as admin"
    And I click to update the user

    Then I should see the admin role as been removed from their account

  Scenario: Ensuring non-admins cannot edit users
    Given I am a non-admin user
    And there is another admin user

    When I am on the "users" page

    Then I should not see any buttons to edit the users
