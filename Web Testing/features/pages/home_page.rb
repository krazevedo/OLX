# encoding: utf-8
# !/usr/bin/env ruby
require 'site_prism'

module Otodom
  module Sections
    class Account < SitePrism::Section      
      element :my_account, 'a#my_account'
    end
  end
  module Sections
    class RightMenu < SitePrism::Section      
      element :advert_button, 'li.navbar-adding a'
      element :user_menu, 'li#user_items'
      elements :items, 'ul#dropdown-menu-user-options li'
    end
  end
  
  module Pages
    class HomePage < SitePrism::Page
      set_url '/'
      section :account, Otodom::Sections::Account, 'li#topLoginArea'
      section :right_menu, Otodom::Sections::RightMenu, '.nav.navbar-nav.navbar-right'
      
      element :body, 'body'
      
      def click_my_account
        sleep(0.5)
        account.my_account.click              
      end  
      def click_advert
        sleep(0.5)
        right_menu.advert_button.click              
      end
      def click_user
        sleep(0.5)
        right_menu.user_menu.click              
      end  
      def click_configuration
        right_menu.items[4].click
      end
      def click_classified
        right_menu.items[1].click
      end
      def click_logout
        right_menu.items[6].click
      end      
      def get_user_logged
        right_menu.user_menu.click
        $user_logged = right_menu.items[0].text.split(":")
      end      
    end
  end
end
