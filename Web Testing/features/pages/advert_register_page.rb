# encoding: utf-8
# !/usr/bin/env ruby
require 'site_prism'

module Otodom
  module Sections
    class AdvertRegister < SitePrism::Section      
      element :title, 'input#add-title'      
      element :price, 'div.col-xs-7 input[name*="param_price"]'
      element :surface, 'input#param7'
      element :rooms, 'select#param57'  
      element :market, 'select#param35'
      element :owner, 'input#checkbox-owner' 
      element :broker, 'input#checkbox-broker'
      element :address, 'div.col-sm-12 span.selection span'
      element :contact_name, 'input#add-person'
      element :email, 'input#add-email'
      element :agreement, 'input#agreement'
      element :preview_link, 'span#preview-link'   
    end
  end 
  module Sections
    class SearchResult < SitePrism::Section      
      element :address_dropdown, 'span.select2-search.select2-search--dropdown input'   
      elements :results, 'ul.select2-results__options li'   
    end
  end
   module Sections
    class Confirm < SitePrism::Section      
      element :success_message, 'h3'
    end
  end
  
  module Pages
    class AdvertRegisterPage < SitePrism::Page
      section :advert, Otodom::Sections::AdvertRegister, 'form#newOffer'                   
      section :search, Otodom::Sections::SearchResult, '.select2-dropdown.select2-dropdown--below'  
      section :confirm, Otodom::Sections::Confirm, '.confirm-page'
        

      def fill_basic_informations
        $title = Faker::Lorem.sentence(2)
        advert.title.set($title)
        advert.price.set(Faker::Number.number(6))
        advert.rooms.select(Faker::Number.between(1, 9)) 
        advert.surface.set(Faker::Number.number(2))
        advert.market.first("option[value='primary']").select_option
        checkbox_hidden(advert.owner(visible: false))                             
      end

      def fill_localization
        sleep(0.5)
        page.execute_script('window.scrollTo(0,900)')
        advert.address.click
        search.address_dropdown.set("a")
        sleep(1)
        search.results[0].click 
        page.execute_script('window.scrollTo(0,1900)')                 
      end

      def fill_contact_details
        page.execute_script('window.scrollTo(0,3200)') 
        advert.contact_name.set(Faker::StarWars.character)
        advert.email.set(Faker::Internet.email) 
        checkbox_hidden(advert.agreement(visible: false))                   
      end

      def fill_contact_details_user_logged
        sleep(0.5)
        page.execute_script('window.scrollTo(0,3200)') 
        advert.contact_name.set(Faker::StarWars.character)                                   
      end

      def preview_link
        page.execute_script('window.scrollTo(0,3500)') 
        sleep(0.5)
        advert.preview_link.click
      end
      
      def checkbox_hidden(element)
        check = element.native
        page.driver.browser.execute_script("arguments[0].click()", check)
      end
    end
  end
end