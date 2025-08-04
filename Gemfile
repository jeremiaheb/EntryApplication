source "https://rubygems.org"

gem "rails", "7.1.5.1"

# PostgreSQL. pg 1.6 removed support for PostgreSQL < 10. The server must be
# upgraded before upgrading to pg >= 1.6.
gem "pg", "~> 1.6"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 6.6"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"
gem "dartsass-sprockets", "~> 3.2", ">= 3.2.1"
gem "sassc-embedded"

gem "nested_form", "0.3.2"

gem "devise", "~> 4.9", ">= 4.9.4"
gem "cancancan", "~> 3.6", ">= 3.6.1"

gem "prawn", "~> 2.5"
gem "prawn-table", "~> 0.2.2"
gem "caxlsx_rails", "~> 0.6.4"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

group :development, :test do
  # Factories and fake data for testing
  gem "factory_bot_rails", "~> 6.5"
  gem "faker", "~> 3.5", ">= 3.5.2"

  gem "pry"

  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  # gem "debug", platforms: %i[ mri windows ]

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
  # gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
end
