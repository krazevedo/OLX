Given(/^I visit the Otodom Page$/) do
  home.load  
end

Given(/^I click in my account button$/) do
  home.click_my_account
end

Given(/^I click in edit profile$/) do
  home.click_user
  home.click_configuration
end

Given(/^I click in register new account$/) do
  login.click_register
  register.click_register_now  
end

Given(/^I log in with the new user changed$/) do
  login.do_login($new_email, $new_password)   
end

Given(/^I log in with the new user$/) do
  login.do_login($email, ENV['password'])   
end

Given(/^I click in advert button$/) do
  home.click_advert  
  sleep(0.5)
  mouse_over(advert.adverts.type[0].path)
  advert.select_options
end

Given(/^I fill the advert$/) do
  advert_register.fill_basic_informations
  advert_register.fill_localization
  tinymce_fill_in("wysiwyg", Faker::Lorem.paragraph(3))
  advert_register.fill_contact_details
  advert_register.preview_link
  preview.sent_preview_advert
end

Given(/^I fill the advert to user logged$/) do
  advert_register.fill_basic_informations
  advert_register.fill_localization
  tinymce_fill_in("wysiwyg", Faker::Lorem.paragraph(3))
  advert_register.fill_contact_details_user_logged
  advert_register.preview_link
  preview.sent_preview_advert
  plans_page.submit_advert
  payment_page.choose_payment
  payu_page.fill_card_details
end

When(/^I fill the new account form$/) do 
  user.fill_basic_informations
end

When(/^I change the password to user logged$/) do 
  configuration.change_password
end

When(/^I change the email to user logged$/) do 
  home.click_user
  home.click_configuration
  configuration.change_email
end

When(/^I log out of site$/) do
   home.click_logout
end

Then(/^I should activate the user$/) do    
  gmail.login_gmail
  gmail.active_user
  gmail.delete_emails
  change_tabs("last")
  expect(success.activeted_success.message.text).to eq("Gratulacje!")  
end

Then(/^I should see the advert$/) do
  advert_register.confirm.wait_for_success_message
  expect(advert_register.confirm.success_message.text).to eq("Odbierz e-mail!")
end

Then(/^I should see home page$/) do 
  home.click_my_account
end

Then(/^I should see the new advert$/) do 
  home.load
  home.click_user
  home.click_classified
  configuration.choose_tab  
  expect(configuration.advert.title.text).to eq($title)
end

Then(/^I should get payment declined message$/) do
  payu_page.error.wait_for_error_title  
end

Then(/^I should enter into the site$/) do
  home.click_user
  home.click_logout
  home.click_my_account
  login.do_login($new_email, $new_password)   
  home.get_user_logged
  expect($new_email.split("@")[0]).to eq $user_logged[0]
end