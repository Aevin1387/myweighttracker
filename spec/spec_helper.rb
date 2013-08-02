require "rubygems"

ENV["RAILS_ENV"] ||= "test"

require "rails/application"

require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "rspec/autorun"
require "capybara/rspec"
require "sidekiq/testing"

include Warden::Test::Helpers

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

Capybara.default_wait_time = 30

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  config.include Devise::TestHelpers, type: :controller
  config.include Warden::Test::Helpers, type: :feature

  config.include FactoryGirl::Syntax::Methods
end

