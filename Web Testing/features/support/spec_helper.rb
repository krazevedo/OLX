# encoding: utf-8
# !/usr/bin/env ruby

Dir[File.join(File.dirname(__FILE__), '../pages/*.rb')].each { |file| require file }

module Otodom
  module Pages
    def success
      Otodom::Pages::RegisterSuccessPage.new
    end

    def home
      Otodom::Pages::HomePage.new
    end

    def login
      Otodom::Pages::LoginPage.new
    end

    def register
      Otodom::Pages::RegisterTypePage.new
    end

    def advert
      Otodom::Pages::AdvertPage.new
    end

    def advert_register
      Otodom::Pages::AdvertRegisterPage.new
    end

    def preview
      Otodom::Pages::PreviewPage.new
    end

    def user
      Otodom::Pages::RegisterPage.new
    end

    def gmail
      Otodom::Pages::GmailPage.new
    end

    def plans_page
      Otodom::Pages::PlansPage.new
    end

    def payment_page
      Otodom::Pages::PaymentPage.new
    end

    def payu_page
      Otodom::Pages::PayUPage.new
    end

    def configuration
      Otodom::Pages::ConfigurationPage.new
    end
  end
end
