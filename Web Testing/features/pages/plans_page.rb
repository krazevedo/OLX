# encoding: utf-8
# !/usr/bin/env ruby
require 'site_prism'

module Otodom
  module Sections
    class Plans < SitePrism::Section      
      element :submit_button, 'button#submit-contact'
    end
  end
  
  module Pages
    class PlansPage < SitePrism::Page
      section :plans, Otodom::Sections::Plans, 'div.form.form-adding div.text-center'
            
      def submit_advert
        sleep(0.5)
        page.execute_script('window.scrollTo(0,3200)')
        plans.submit_button.click              
      end            
    end
  end
end