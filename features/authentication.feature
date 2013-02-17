Feature: Authentication
  Scenario: Creating a new account
    Given I am not authenticated
    When I go to register 
    And I fill in "user_username" with "testerson"
    And I fill in "user_email" with "test@test.com"
    And I fill in "user_password" with "abc123456"
    And I fill in "user_password_confirmation" with "abc123456"
    And I press "Sign up"
    Then I should be redirected to the "home" page
    And I should see the element "username" 

  Scenario: Logging in to an existing account
    Given I am not authenticated
    And I have an existing account
    When I go to login
    And I fill in the login form 
    And I press "Sign in"
    Then I should be redirected to the "home" page
    And I should see the element "username" 

  Scenario: Logging out of an authenticated session
    Given I am logged in
    When I click "log out"
    Then I should be redirected to the "home" page
    And I should not see the element "username"
