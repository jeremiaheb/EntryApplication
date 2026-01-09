source "https://rubygems.org"

gem "rails", "8.0.4"
# Minitest 6 is not yet compatible with Rails 8/8.1: https://github.com/rails/rails/issues/56406
gem "minitest", "~> 5.27", "< 6"

# PostgreSQL. pg 1.6 removed support for PostgreSQL < 10. The server must be
# upgraded before upgrading to pg >= 1.6.
gem "pg", "~> 1.5", "< 1.6"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 7.1"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"
gem "dartsass-sprockets", "~> 3.2", ">= 3.2.1"
gem "sassc-embedded"

# Google Cloud
gem "google-cloud-storage", "~> 1.58", require: "google/cloud/storage"

gem "jquery-ui-rails", "~> 8.0"
gem "nested_form", "0.3.2"

gem "devise", "~> 4.9", ">= 4.9.4"
gem "omniauth", "~> 2.1"
gem "omniauth-rails_csrf_protection", "~> 2.0"
gem "omniauth_openid_connect", "~> 0.8.0"
gem "cancancan", "~> 3.6", ">= 3.6.1"

gem "prawn", "~> 2.5"
gem "prawn-table", "~> 0.2.2"
gem "caxlsx_rails", "~> 0.6.4"
gem "csv", "~> 3.3", ">= 3.3.5"

# App-internal exception tracker [https://github.com/fractaledmind/solid_errors]
gem "solid_errors", "~> 0.7.0"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

group :development, :test do
  # Factories and fake data for testing
  gem "factory_bot_rails", "~> 6.5"
  gem "faker", "~> 3.5"

  gem "pry"

  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  # gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false

  # Find and fix N+1 queries more easily [https://github.com/flyerhzm/bullet]
  gem "bullet"
end

group :development do
  gem "capistrano", require: false
  gem "capistrano-rails", require: false
  gem "capistrano-rbenv", require: false

  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  # Workaround for https://github.com/teamcapybara/capybara/issues/2800
  gem "capybara-lockstep"
  gem "selenium-webdriver"
end
