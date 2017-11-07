Feature: User register

  Background:
    Given I visit the Otodom Page

      Scenario: Create Advert to user not logged 
        Given I click in advert button 
        When I fill the advert 
        Then I should see the advert

    Scenario: Register and activate a new user
      Given I click in my account button 
      And I click in register new account
      When I fill the new account form 
      Then I should activate the user

    Scenario: Create a new advert with this user
      Given I click in my account button 
      And I log in with the new user
      And I click in advert button 
      When I fill the advert to user logged
      Then I should get payment declined message
      And I should see the new advert

    Scenario: Edit informations of the new user
      Given I click in my account button 
      And I log in with the new user
      And I click in edit profile 
      When I change the password to user logged
      And I change the email to user logged
      Then I should enter into the site

    Scenario: Login and Logout with new informations
      Given I click in my account button 
      When I log in with the new user changed
      Then I should enter into the site
      When I log out of site
      Then I should see home page      