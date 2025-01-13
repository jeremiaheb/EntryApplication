source 'https://rubygems.org'

ruby '2.7.8'
gem 'rails', '~> 6.1.7', '>= 6.1.7.10'

gem 'pg', '~> 1.4', '>= 1.4.6'

gem 'puma', '~> 5.0'

# TODO: Replace with strong_parameters. This gem is no longer maintained and
# will no longer work after Rails 6.1
gem 'protected_attributes_continued'

gem 'sass-rails', '~> 5.0'
gem 'coffee-rails'
gem 'jbuilder', '~> 2.7'

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

gem 'prawn', :git => 'https://github.com/prawnpdf/prawn.git'
gem 'prawn-table'
gem 'axlsx_rails'

gem 'net-ssh'
gem 'capistrano', '~> 3.7', '>= 3.7.1'
gem 'capistrano-rails', '~> 1.2'
gem 'capistrano-passenger', '~> 0.2.0'
gem 'capistrano-rbenv', '~> 2.1'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'factory_girl_rails'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'rspec-rails', '6.1.5'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

group :production do
  gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
