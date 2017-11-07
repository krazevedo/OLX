# encoding: utf-8
# !/usr/bin/env ruby
require 'site_prism'

module Otodom
  module Sections
    class Preview < SitePrism::Section      
      element :sent_button, 'div a.btn.btn-default'
    end
  end
  module Sections
    class Confirm < SitePrism::Section      
      element :success_message, 'h3'
    end
  end
  
  module Pages
    class PreviewPage < SitePrism::Page
      section :preview, Otodom::Sections::Preview, '.article-offer' 
      section :confirm, Otodom::Sections::Confirm, '.confirm-page'

      def sent_preview_advert
        sleep(0.5)
        preview.sent_button.click              
      end
      def verify_success_message
        sleep(0.5)
        confirm.wait_for_success_message
        expect(confirm.success_message.text).to eq("Odbierz e-mail!")
                
      end            
    end
  end
end
