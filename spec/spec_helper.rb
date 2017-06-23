require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara-screenshot/rspec'
require 'selenium-webdriver'
require 'active_support/all'

driver = if ENV['SHOWME']
          #  Capybara.register_driver :chrome do |app|
          #    client = Selenium::WebDriver::Remote::Http::Default.new
          #    client.timeout = 120
          #    Capybara::Selenium::Driver.new(app, browser: :chrome, http_client: client)
          #  end
           :selenium
         else
           Capybara.register_driver :poltergeist do |app|
             Capybara::Poltergeist::Driver.new(app, { js_errors: true })
           end
           :poltergeist
         end

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

Capybara::Screenshot.prune_strategy = { keep: 1 }
Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
  "#{example.metadata[:file_path].gsub(/(^\.\/.+\/|\.rb)/, '')}_#{example.metadata[:line_number]}_#{example.description}"
end
