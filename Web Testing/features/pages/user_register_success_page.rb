# encoding: utf-8
# !/usr/bin/env ruby
require 'site_prism'

module Otodom
  module Sections
     class Success < SitePrism::Section
        element :message, 'h3'        
      end
  end
  module Pages
    class RegisterSuccessPage < SitePrism::Page
      section :activeted_success, Otodom::Sections::Success, '.confirm-page.successbox'                  
    end
  end
end
