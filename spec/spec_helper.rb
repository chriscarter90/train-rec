ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'database_cleaner' 
require 'be_valid_asset'

Capybara.javascript_driver = :poltergeist
Capybara.default_wait_time = 4 # Give some extra time for slow AJAX/JS actions to complete
 
# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
Dir[Rails.root.join("spec/features/support/**/*.rb")].each { |f| require f }
Dir[Rails.root.join("spec/models/concerns/**/*.rb")].each { |f| require f }

# Require shared examples
Dir["./spec/**/shared/*.rb"].sort.each {|f| require f}

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.treat_symbols_as_metadata_keys_with_true_values = true

  # If you have some extra methods in modules you may want to include them in specific types of tests:  
  config.include BeValidAsset, type: :feature
  # config.include CapybaraSessionExtensions, type: :feature
  
  # Disable should syntax, ues the new expect syntax instead:
  config.expect_with :rspec do |config|
    config.syntax = :expect
  end
 
  # Clear the test database out completely before the entire test suite runs.
  # This gets rid of any garbage left over from interrupted or
  # poorly-written tests—a common source of surprising test behavior.
 
  if ENV['FULL_FEATURE_TEST'] == 'true'
    config.before :suite do
      DatabaseCleaner.clean_with :truncation
    end
 
    # Use transactional database cleaning strategy by default.
    config.before :each do
      DatabaseCleaner.strategy = :transaction
    end
 
    # Use truncation for tests where Capybara fires up external browser environments,
    # such as Poltergeist.
    config.before :each, type: :feature do
      DatabaseCleaner.strategy = :truncation
      Capybara.current_driver = :poltergeist
    end
 
    config.after :each do
      Capybara.default_driver = :rack_test
    end
 
    # Execute whatever cleanup strategy we selected beforehand.
    config.before :each do
      DatabaseCleaner.start
      puts "CURRENT DRIVER: #{Capybara.current_driver}"
    end
 
    # Clean the database after each test.
    config.after :each do
      DatabaseCleaner.clean
    end
 
  else
    config.before :suite do
      DatabaseCleaner.clean_with :truncation
    end
 
    # Use transactional database cleaning strategy by default.
    config.before :each do
      DatabaseCleaner.strategy = :transaction
    end
 
    # Use truncation for tests where Capybara fires up external browser environments,
    # such as Poltergeist.
    config.before :each, js: true do
      DatabaseCleaner.strategy = :truncation
    end
 
    # Execute whatever cleanup strategy we selected beforehand.
    config.before :each do
      DatabaseCleaner.start
    end
 
    # Clean the database after each test.
    config.after :each do
      DatabaseCleaner.clean
    end
  end
end
