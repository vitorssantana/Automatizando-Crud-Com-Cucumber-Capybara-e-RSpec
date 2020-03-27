require 'capybara/cucumber'
require 'selenium-webdriver'
require 'site_prism'
 
Capybara.default_driver = :selenium
Capybara.default_max_wait_time = 20
Capybara.javascript_driver = :webkit
Capybara.default_driver = :selenium_chrome
Capybara.app_host = "https://www.jeasyui.com/tutorial/app/crud/index.html"
World(Capybara::DSL)
World(Capybara::RSpecMatchers)