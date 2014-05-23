# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/poltergeist'
#require "pundit/rspec"
Capybara.javascript_driver = :poltergeist

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = false

  config.infer_base_class_for_anonymous_controllers = false
  config.include FactoryGirl::Syntax::Methods
  #config.include I18nTestHelpers
  #config.include TimeTestHelpers
  #config.include PdfContentHelpers

  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.before(:each) do
    if Capybara.current_driver == :rack_test 
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.start  
    else
      Capybara.server_port = 7171
      DatabaseCleaner.strategy = :truncation
    end
  end

  config.after(:each) do
    DatabaseCleaner.clean      
  end

  # handle paperclip uploads
  config.after(:suite) do
    path = File.join(Rails.root.to_s, 'public', 'test')
    if File.directory?(path)
      FileUtils.remove_dir(path)
    end
  end

  config.order = "random"
end
