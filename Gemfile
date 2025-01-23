source "https://rubygems.org"

ruby "3.2.6"
gem "rails", "~> 7.1.5", ">= 7.1.5.1"

gem 'pg', '~> 1.5', '>= 1.5.9'

gem "puma", ">= 5.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

gem 'sass-rails', '~> 5.0'
gem 'jbuilder'

gem 'jquery-ui-rails', '~> 5.0'
gem 'jquery-rails'
gem 'jquery-datatables-rails', git: 'https://github.com/rweng/jquery-datatables-rails.git'
gem 'jquery-validation-rails'
gem 'bootstrap-sass', '~> 2.3', '>= 2.3.2.2'
gem 'bootstrap-datepicker-rails'
gem 'nested_form'
gem "blueimp-gallery"

gem 'devise', '~> 4.4', '>= 4.4.3'
gem 'cancancan', '~> 3.0'

gem 'prawn', '~> 2.5'
gem 'prawn-table', '~> 0.2', '>= 0.2.2'
gem 'caxlsx_rails', '0.6.4'

gem 'net-ssh'
gem 'capistrano', '~> 3.7', '>= 3.7.1'
gem 'capistrano-rails', '~> 1.2'
gem 'capistrano-passenger', '~> 0.2.0'
gem 'capistrano-rbenv', '~> 2.1'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'factory_girl_rails'

  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]

  # TODO: Upgrade to faker 3.x after upgrade to Ruby 3 is complete
  gem 'faker', '~> 3.4', '>= 3.4.2'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
end

group :production do
  gem 'rails_12factor'
end
