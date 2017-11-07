
Feature: API Testing

  Background:
    Given I have the endpoint "clients"

  Scenario: Create two new clients 
    
   Given I create the body for "2" new clients
   When I POST the correct parameters 
   Then I should create the new clients

Scenario: Create new clients except ID 
    
    Given I create the body for "1" new clients except the ID
    Then I should see a duplicate id error message     

Scenario: Edit information of a client 
    
    Given I create the body for a client
    When I PUT the modify parameters for the client "1" 
    Then I should update the client

Scenario: Delete a client 
    
    Given I create the request to delete the client "3"
    When I send the request 
    Then the client should be deleted