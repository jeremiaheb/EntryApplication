source 'https://rubygems.org'

ruby '2.6.10'
gem 'rails', '~> 6.0', '>= 6.0.6.1'

# TODO: Remove after upgrading to Rails 7
# See https://github.com/rails/rails/issues/54263
gem 'concurrent-ruby', '< 1.3.5'

gem 'pg'

# < 6 until Ruby 2.7. Bump capybara alongside that too.
gem 'puma', '>= 5.0', '< 6'

gem 'sass-rails', '~> 5.0'

gem 'jquery-ui-rails', '5.0.5'
gem 'jquery-rails', '4.3.1'
gem 'jquery-datatables-rails', '3.4.0'
gem 'jquery-validation-rails', '1.16.0'
gem 'twitter-bootstrap-rails', '2.2.8'
gem 'bootstrap-datepicker-rails', '1.6.4.1'
gem 'select2-rails', '3.2.1'
gem 'nested_form', '0.3.2'

gem 'devise', '~> 4.9', '>= 4.9.4'
gem 'cancancan', '~> 2.0'

gem 'prawn', '~> 2.2', '>= 2.2.2'
gem 'prawn-table', '~> 0.2', '>= 0.2.2'
gem 'caxlsx_rails'

gem 'capistrano'
gem 'capistrano-rails'
gem 'capistrano-rbenv'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development do
  gem 'listen', '~> 3.2'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
end

group :development, :test do
  # TODO: Upgrade after upgrade to Ruby 3 is complete
  gem 'factory_bot_rails', '~> 5.2', '< 6'
  gem 'pry'

  # TODO: Upgrade to faker 3.x after upgrade to Ruby 3 is complete
  gem 'faker', '~> 2.22'
end
