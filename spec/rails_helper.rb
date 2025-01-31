# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

require 'capybara/rspec'

# Register selenium_chrome driver
Capybara.register_driver :selenium_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')  # Uncomment this line for headless mode
  options.add_argument('--disable-gpu')  # Optional for Windows
  
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.default_driver = :selenium_chrome
Capybara.javascript_driver = :selenium_chrome

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. It is recommended not to name files matching this glob
# to end with _spec.rb to avoid double loading.
#
# Rails.root.glob('spec/support/**/*.rb').sort_by(&:to_s).each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_paths = [
    Rails.root.join('spec/fixtures')
  ]
  
  config.before(:suite) do
    if ActiveRecord::Base.connection.tables.empty?
      Rails.application.load_tasks
      Rake::Task['db:create'].invoke
      Rake::Task['db:schema:load'].invoke
    end
  end

  config.use_transactional_fixtures = false
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # Use factory_bot_rails (if you're using it instead of factory_girl_rails)
  require 'factory_bot_rails'
  config.include FactoryBot::Syntax::Methods

  # Include Devise helpers for feature specs
  config.include Devise::Test::IntegrationHelpers, type: :feature
  
  # Specify JavaScript driver
  Capybara.javascript_driver = :selenium_chrome
  
  # Configure Capybara server
  Capybara.server = :puma
  # In rails_helper.rb
  Dir[Rails.root.join('spec/factories/**/*.rb')].each { |file| require file }

  # Configure RSpec to infer spec type based on file location
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces
  config.filter_rails_from_backtrace!
end
