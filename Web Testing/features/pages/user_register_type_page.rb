# encoding: utf-8
# !/usr/bin/env ruby
require 'site_prism'

module Otodom
  module Sections
    class RegisterType < SitePrism::Section      
      element :register_now, 'div.register-box.register-box-business a.btn.btn-default'
      element :facebook, 'div.login-box__alternative a'
    end
  end
  
  module Pages
    class RegisterTypePage < SitePrism::Page
      section :register_type_user, Otodom::Sections::RegisterType, '#uzytkownicy-indywidualni'
      
      def click_register_now
        sleep(1)
        register_type_user.register_now.click                
      end
    end
  end
end
