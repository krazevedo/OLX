# encoding: utf-8
# !/usr/bin/env ruby
require 'fileutils'
module Helper
    # Custom commands
    def mouse_over(element_selector)
      element = Capybara.page.driver.browser.find_element(:xpath, element_selector)
      Capybara.page.driver.browser.mouse.move_to element
    end
    # Screenshots
    def take_screenshot(file_name, result)
      timer_path = Time.now.strftime('%Y_%m_%d').to_s
      file_path = "screenshots/test_#{result}/run_#{timer_path}"
      screenshot = "#{file_path}/#{file_name}.png"
      page.save_screenshot(screenshot,  :full => true)
      embed(screenshot, 'image/png', 'SCREENSHOT')
    end
    # Tinymce
    def tinymce_fill_in(name, text)
      if page.driver.browser.browser == :chrome
        page.driver.browser.switch_to.frame("#{name}_ifr")
        page.find(:css, '#tinymce').native.send_keys(text)
        page.driver.browser.switch_to.default_content
      else
        page.execute_script("tinyMCE.get('#{name}').setContent('#{options[:with]}')")
      end
    end  

    def change_tabs(tab)
      window = page.driver.browser.window_handles
      if tab == "last"
       page.driver.browser.switch_to.window(window.last)
      else 
       page.driver.browser.switch_to.window(window.first)
      end
    end  
end
