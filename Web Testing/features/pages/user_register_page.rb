# encoding: utf-8
# !/usr/bin/env ruby
require 'site_prism'

module Otodom
  module Sections
      class GeneralData < SitePrism::Section
        element :email, 'div input#userEmail'
        element :password, 'div input#userPass'
        element :confirm_password, 'div input#userPass-repeat'
        element :agreement, 'div input#checkbox-rules' 
        element :submit, 'button.btn.btn-default'
      end
  end
  module Pages
    class RegisterPage < SitePrism::Page
      section :register_user, Otodom::Sections::GeneralData, '#mainForm'
      
      def fill_basic_informations
          $email = "qachallengept+" + Faker::Number.number(4) + "@gmail.com"  
          register_user.email.set($email)
          register_user.password.set(ENV['password'])
          register_user.confirm_password.set(ENV['password']) 
          checkbox_hidden(register_user.agreement(visible: false))
          register_user.submit.click                                    
      end

      def checkbox_hidden(element)
        check = element.native
        page.driver.browser.execute_script("arguments[0].click()", check)
      end
    end
  end
end
