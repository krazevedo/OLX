# encoding: utf-8
# !/usr/bin/env ruby
require 'site_prism'

module Otodom
  module Sections
    class Form < SitePrism::Section      
      element :cardnumber, 'div input[name="number"]'
      element :expire, 'div input[name="date"]'
      element :cvv, 'div input[name="cvv"]'
      element :button, 'div input[name="submit"]'
    end
  end

  module Sections
    class Error < SitePrism::Section      
      element :error_title, 'h1'      
    end
  end
  
  module Pages
    class PayUPage < SitePrism::Page
      section :form, Otodom::Sections::Form, 'article.payment-card'
      section :error, Otodom::Sections::Error, 'article.status.unknown'
            
      def fill_card_details
        time = Time.new
        form.cardnumber.set(Faker::CreditCard.number(:visa, length: 16))
        form.expire.set(time.month.to_s + "/" + (time.year + 3).to_s)
        form.cvv.set(Faker::Number.number(3))
        form.button.click
      end 

      def verify_message_denied
        binding.pry
        error.wait_for_error_title
        expect(error.error_title.text).to eq("Erro de autorização")  
      end       
    end
  end
end