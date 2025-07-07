source 'https://rubygems.org'

ruby '2.5.9'
gem 'rails', '~> 5.2.8', '>= 5.2.8.1'

gem 'pg'

gem 'puma', '~> 3.11'

# TODO: Replace with strong_parameters. This gem is no longer maintained and
# will no longer work after Rails 6.1
gem 'protected_attributes_continued'

# TODO: Evaluate whether these gems are needed anymore.
gem 'json'
gem 'multi_json'

gem 'sass-rails', '~> 5.0'
gem 'coffee-rails'
gem 'jbuilder', '~> 2.5'

gem 'jquery-ui-rails', '~> 5.0'
gem 'jquery-rails'
gem 'jquery-datatables-rails', git: 'https://github.com/rweng/jquery-datatables-rails.git'
gem 'jquery-validation-rails'

gem 'twitter-bootstrap-rails', '2.2.8'
gem 'bootstrap-datepicker-rails'

gem 'select2-rails', '3.2.1'
gem 'nested_form'

gem 'devise', '~> 4.4', '>= 4.4.3'
gem 'cancancan', '~> 2.0'

gem 'prawn', :git => 'https://github.com/prawnpdf/prawn.git'
gem 'prawn-table'
gem 'axlsx_rails'

gem 'net-ssh'
gem 'figaro'
gem "blueimp-gallery"

gem 'capistrano'
gem 'capistrano-rails'
gem 'capistrano-rbenv'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :production do
  gem 'rails_12factor'
end

group :test do
  gem 'rspec-rails', '3.5.1'

  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

group :development, :test do
  gem 'ruby-prof'
  gem 'rails-erd'
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'factory_girl_rails'
  #gem 'quiet_assets'
end
