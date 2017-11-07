# encoding: utf-8
# !/usr/bin/env ruby
require 'site_prism'

module Otodom
  module Sections
    class TypesAdvert < SitePrism::Section
     elements :type, 'li[class=item]'   
     elements :options, 'ul[class=item-options] li'              
    end
  end   
 
  module Pages
    class AdvertPage < SitePrism::Page
      section :adverts, Otodom::Sections::TypesAdvert, '.featured-list'      
      
      def select_options
        sleep(1)
        adverts.options[0].click        
      end
    end
  end
end
