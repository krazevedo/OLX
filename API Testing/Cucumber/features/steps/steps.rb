Given(/^I have the endpoint "([^"]*)"$/) do |endpoint|
  @url = 'http://localhost:3000/' + endpoint
end

Given(/^I create the body for "([^"]*)" new clients$/) do |quantity|
 @body = Array.new 
 @qtd = quantity.to_i - 1
 for i in 0..@qtd do
    @body[i] = {
      "name": Faker::GameOfThrones.character,
      "document_id": Faker::Number.number(10),
      "address": Faker::Address.street_address,
      "user": Faker::Internet.user_name,
      "password": Faker::Internet.password(8)
    }.to_json
  end
end

Given(/^I create the body for "([^"]*)" new clients except the ID$/) do |quantity|
 @body = Array.new 
 @qtd = quantity.to_i - 1
 for i in 0..@qtd do
    @body[i] = {
      "name": Faker::GameOfThrones.character,
      "document_id": Faker::Number.number(10),
      "address": Faker::Address.street_address,
      "user": Faker::Internet.user_name,
      "password": Faker::Internet.password(8),
      "id": 1
    }.to_json
  end
end

Given(/^I create the body for a client$/) do 
  @new_name = Faker::StarWars.character
  @new_document_id = Faker::Number.number(8)
  @new_address = Faker::Address.street_address
  @new_user = Faker::Internet.user_name(@new_name)
  @new_password = Faker::Internet.password(6)
  @body_put = {
      "name": @new_name,
      "document_id": @new_document_id,
      "address": @new_address,
      "user": @new_user,
      "password": @new_password
    }.to_json
end

Given(/^I create the request to delete the client "([^"]*)"$/) do |id|
  @url = @url + '/' + id
  @body_delete = {
    "id": id
  }.to_json
end
  

When(/^I POST the correct parameters$/) do 
  for i in 0..@qtd do
    @post_clients = HTTParty.post @url,
      :body => @body[i],
      :headers => {
          "Content-Type" => 'application/json'
      }
    expect(@post_clients.code).to eq 201  
  end
end


When(/^I PUT the modify parameters for the client "([^"]*)"$/) do |id|
  @put = HTTParty.put @url + '/' + id,
    :body => @body_put,
    :headers => {
      "Content-Type" => 'application/json'
    }  
end

When(/^I send the request$/) do
 @delete = HTTParty.delete @url,
    :body => @body_delete,
    :headers => {
      "Content-Type" => 'application/json'
    }
end

Then(/^I should create the new clients$/) do
  @get_clients = HTTParty.get @url
  expect(@get_clients.code).to eq 200
end

Then(/^I should see a duplicate id error message$/) do 
  for i in 0..@qtd do
    @post_clients = HTTParty.post @url,
      :body => @body[i],
      :headers => {
          "Content-Type" => 'application/json'
      }
    expect(@post_clients.body.split(".")[0]).to eq ("Error: Insert failed; duplicate id")
    expect(@post_clients.code).to eq 500 
  end
end

Then(/^I should update the client$/) do
  expect(@put.code).to eq 200
  expect(@put["name"]).to eq @new_name
  expect(@put["document_id"]).to eq @new_document_id
  expect(@put["address"]).to eq @new_address
  expect(@put["user"]).to eq @new_user
  expect(@put["password"]).to eq @new_password
end

Then(/^the client should be deleted$/) do
  expect(@delete["id"]).to eq nil
end