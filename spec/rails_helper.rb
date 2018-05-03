require 'simplecov'
SimpleCov.start
# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
# require 'spec_helper'
require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'
require 'factory_girl_rails'
Dir[Rails.root.join('spec', 'support', '*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
