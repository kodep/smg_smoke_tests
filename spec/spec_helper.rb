require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara-screenshot/rspec'
require 'active_support/all'
require "selenium/webdriver"
require 'capybara-screenshot/rspec'
require 'support/factory_girl'
require 'faker'


Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w(headless disable-gpu) }
  )

  Capybara::Selenium::Driver.new app,
    browser: :chrome,
    desired_capabilities: capabilities
end

driver = :headless_chrome

Capybara.configure do |config|
  config.save_path = "#{__dir__}/screens"
  config.javascript_driver = driver
  config.app_host = 'http://localhost:3000'
end

%w(helpers resource_helpers steps matchers).each do |folder|
  Dir["#{File.join(File.dirname(__FILE__), 'support', folder)}/*.rb"].each do |file|
    require file
    unless folder == 'matchers'
      include File.basename(file).gsub('.rb', '').camelize.constantize
    end
  end
end

RSpec.configure do |config|
  config.after(:each) do
    if page.html.size > 39
      evaluate_script('localStorage.clear();')
      sleep 2
    end
    FactoryGirl.reload
  end
  config.append_after(:each) do
    Capybara.reset_sessions!
  end
end

def cache
  $cache ||= ActiveSupport::Cache::MemoryStore.new
end
Capybara::Screenshot.register_driver(:headless_chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end
Capybara::Screenshot.prune_strategy = { keep: 1 }
Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
  "#{example.metadata[:file_path].gsub(/(^\.\/.+\/|\.rb)/, '')}_#{example.metadata[:line_number]}_#{example.description}"
end
