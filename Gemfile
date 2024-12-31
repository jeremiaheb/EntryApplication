source 'https://rubygems.org'

ruby '2.6.10'
gem 'rails', '~> 6.0.6', '>= 6.0.6.1'

gem 'pg'

gem 'puma', '~> 4.1'

# TODO: Replace with strong_parameters. This gem is no longer maintained and
# will no longer work after Rails 6.1
gem 'protected_attributes_continued'

# TODO: Evaluate whether these gems are needed anymore.
gem 'json'
gem 'multi_json'

gem 'sass-rails', '~> 5.0'
gem 'jbuilder', '~> 2.7'

gem 'jquery-ui-rails', '~> 5.0'
gem 'jquery-rails'
gem 'jquery-datatables-rails', git: 'https://github.com/rweng/jquery-datatables-rails.git'
gem 'jquery-validation-rails'
gem 'twitter-bootstrap-rails'
gem 'less-rails-bootstrap'
gem 'bootstrap-datepicker-rails'
gem 'select2-rails', '3.2.1'
gem 'nested_form'
gem "blueimp-gallery"

gem 'devise', '~> 4.4', '>= 4.4.3'
gem 'cancancan', '~> 2.0'

gem 'prawn', :git => 'https://github.com/prawnpdf/prawn.git'
gem 'prawn-table'
gem 'axlsx_rails'

gem 'net-ssh'
gem 'capistrano', '~> 3.7', '>= 3.7.1'
gem 'capistrano-rails', '~> 1.2'
gem 'capistrano-passenger', '~> 0.2.0'
gem 'capistrano-rbenv', '~> 2.1'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'factory_girl_rails'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rspec-rails', '3.5.1'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

group :production do
  gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
