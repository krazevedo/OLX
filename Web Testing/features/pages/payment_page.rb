# encoding: utf-8
# !/usr/bin/env ruby
require 'site_prism'

module Otodom
  module Sections
    class CreditCard < SitePrism::Section      
      element :visa_credit_card, 'input#button_cv'
    end
  end
  
  module Pages
    class PaymentPage < SitePrism::Page
      section :creditcard, Otodom::Sections::CreditCard, '.buttons-container.buttons-container-top'
            
      def choose_payment
        sleep(0.5)
        creditcard.visa_credit_card.click              
      end            
    end
  end
end