source 'https://rubygems.org'

ruby '2.5.9'
gem 'rails', '~> 5.2.8', '>= 5.2.8.1'

gem 'pg'

# < 6 until Ruby 2.7. Bump capybara alongside that too.
gem 'puma', '>= 5.0', '< 6'

# TODO: Replace with strong_parameters. This gem is no longer maintained and
# will no longer work after Rails 6.1
gem 'protected_attributes_continued'

gem 'sass-rails', '~> 5.0'

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

gem "blueimp-gallery"

gem 'capistrano'
gem 'capistrano-rails'
gem 'capistrano-rbenv'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

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
