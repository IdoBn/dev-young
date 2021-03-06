# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'factory_girl_rails'
require 'support/global_helpers'
require 'sidekiq/testing'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # factory girl configs
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end

  # geocoder
  config.before(:each) do
    Group.any_instance.stub(:geocode) { {latitude: 40.6891988, longitude: -74.0445167} }
  end

  # setting stuff up
  config.include DevYoung::GlobalHelpers

  # setting up omniauth facebook
  RACK_ENV = ENV['ENVIRONMENT'] ||= 'test'
  OmniAuth.config.test_mode = true
  omniauth_hash =
      {:provider => "facebook",
       :uid      => "100008238285369",
       :info   => {:name       => 'Maria Amhbchbhecfi Narayananman',
                   :email      => 'azxdapn_narayananman_1399144402@tfbnw.net'},
       :credentials => {:token => 'CAAEKU6pnZCngBAJgDG4ACqq3tnJ3c7ue5wZAksudu7cEd9LTQrKQPWNSQRl0dkw73QrG9EQBJSx0PbXjKSRZCqjZBUtW2HlRrLursNZC5LB7YHR2Pcchl4FGSYR9ErAYNTvaPNNZArhZAJgxZAclKWQSwOfwXM9Rf1mGSF5rZC97M92o4MCIkdHki3S8Jf2r0he8ZD',
                        expires_at: 1.hour.from_now}
      }

  OmniAuth.config.add_mock(:facebook, omniauth_hash)
end
