# encoding: utf-8
# !/usr/bin/env ruby
require 'site_prism'

module Otodom
  module Sections
      class Login < SitePrism::Section
        element :email, 'div input#identifierId'
        element :next, 'div#identifierNext > content > span'
        element :password, 'div input[name=password]' 
        element :second_next, 'div#passwordNext > content > span'       
      end
  end

  module Sections
      class Inbox < SitePrism::Section
        elements :recent_email, 'div.yW span'
      end
  end

  module Sections
      class Email < SitePrism::Section
        element :link, 'a[id*=confirmLink]'
      end
  end
  module Pages
    class GmailPage < SitePrism::Page
      section :box_login_gmail, Otodom::Sections::Login, '#initialView'
      section :inbox, Otodom::Sections::Inbox, 'div.Cp' 
      section :email, Otodom::Sections::Email, 'div.adn.ads' 

      def login_gmail
        visit("https://mail.google.com") 
        sleep(1) 
        box_login_gmail.email.set(ENV['user'])
        box_login_gmail.next.click
        box_login_gmail.password.set(ENV['password'])
        box_login_gmail.second_next.click
      end

      def active_user        
        inbox.recent_email[0].click
        email.link.click             
      end 

      def delete_emails
        gmail = nil
        until gmail != nil do
          gmail = Gmail.connect!(ENV['user'], ENV['password'])
        end
        gmail.inbox.find(:from => "powiadomienia@otodom.pl").each do |email|
          email.delete!             
        end
        gmail.logout
      end     
    end
  end
end
