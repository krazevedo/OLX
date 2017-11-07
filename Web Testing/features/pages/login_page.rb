# encoding: utf-8
# !/usr/bin/env ruby
require 'site_prism'

module Otodom
  module Sections
    class Login < SitePrism::Section      
      element :login_field, 'input#login'
      element :password_field, 'input#password'
      element :sign_in, 'button.btn.btn-default'      
    end
  end
  module Sections
    class Register < SitePrism::Section      
      element :register_button, 'a'
    end
  end
  module Pages
    class LoginPage < SitePrism::Page
      section :login, Otodom::Sections::Login, '.login-box'
      section :register, Otodom::Sections::Register, '.register-box-container'
      
      def do_login(user, pwd)
        sleep(1.5)
        login.login_field.set(user)
        login.password_field.set(pwd)
        login.sign_in.click
      end

      def click_register
        register.register_button.click
      end
    end
  end
end
