Feature: Authentication
  Scenario: Creating a new account
      Given I am not authenticated
      When I go to register 
      And I fill in "user_email" with "<email>"
      And I fill in "user_password" with "<password>"
      And I fill in "user_password_confirmation" with "<password>"
      And I press "Sign up"
      Then I should see "logged in as <email>" 

  Scenario: Willing to edit my account
      Given I am a new, authenticated user
      When I want to edit my account
      Then I should see the account initialization form
      And I should see "Your account has not been initialized yet. Do it now!"
