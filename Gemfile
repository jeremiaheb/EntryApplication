source "https://rubygems.org"

gem "rails", "7.1.5.1"

# TODO: Remove after upgrading to Rails 7
# See https://github.com/rails/rails/issues/54263
gem "concurrent-ruby", "< 1.3.5"

gem "pg", "~> 1.5", ">= 1.5.9"

gem "puma", "~> 6.6"

gem "dartsass-sprockets", "~> 3.2", ">= 3.2.1"
gem "sassc-embedded"

gem "nested_form", "0.3.2"

gem "devise", "~> 4.9", ">= 4.9.4"
gem "cancancan", "~> 3.6", ">= 3.6.1"

gem "prawn", "~> 2.5"
gem "prawn-table", "~> 0.2.2"
gem "caxlsx_rails", "~> 0.6.4"

gem "capistrano"
gem "capistrano-rails"
gem "capistrano-rbenv"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.4", require: false

group :development do
  gem "listen", "~> 3.3"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver", ">= 4.0.0.rc1"
end

group :development, :test do
  gem "factory_bot_rails", "~> 6.5"
  gem "faker", "~> 3.5", ">= 3.5.2"
  gem "pry"

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
end
