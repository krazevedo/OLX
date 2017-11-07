# encoding: utf-8
# !/usr/bin/env ruby
require 'site_prism'

module Otodom
  module Sections
      class NewPassword < SitePrism::Section
        element :current_password, 'input[name*="current_password"]'
        element :new_password, 'input#se_chPassword'
        element :confirm_new_password, 'input#se_chRepeatPassword' 
        element :change_password_button, 'button#passwordInput'
      end
  end
  module Sections
      class NewEmail < SitePrism::Section
        element :new_email, 'input#se_chEmail'
        element :password, 'input#se_chPassword' 
        element :change_email_button, 'button#mailSubmit'
      end 
  end
  module Sections
      class Tabs < SitePrism::Section
        elements :tabs, 'li'        
      end 
  end
  module Sections
      class Advert < SitePrism::Section
        element :title, 'h5'        
      end 
  end
  module Pages
    class ConfigurationPage < SitePrism::Page
      section :password, Otodom::Sections::NewPassword, 'form#newPasswordForm'
      section :email, Otodom::Sections::NewEmail, 'form#changeemailForm' 
      section :advert, Otodom::Sections::Advert, 'div.item-main' 
      section :tab, Otodom::Sections::Tabs, 'ul#globalLinks' 

      def change_password
          $new_password = "inicial4321"  
          password.current_password.set(ENV['password'])
          password.new_password.set($new_password)
          password.confirm_new_password.set($new_password)
          password.change_password_button.click                                    
      end

      def change_email
          $new_email = "qachallengept+" + Faker::Number.number(4) + "@gmail.com"  
          page.execute_script('window.scrollTo(0,3200)')
          email.new_email.set($new_email)
          email.password.set($new_password)
          email.change_email_button.click                                    
      end      

      def choose_tab
        binding.pry
        tab.tabs[1].click
      end
    end
  end
end