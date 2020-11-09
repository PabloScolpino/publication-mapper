source 'https://rubygems.org'
ruby '2.6.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0'
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Templating
gem 'slim-rails'
gem 'simple_form'
# gem "simple_form", ">= 5.0.0"
gem 'country_select'
gem 'redcarpet'

# use puma as the webserver
gem 'puma'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
# bundle exec rake doc:rails generates the API under doc/api.
#gem 'sdoc', '~> 0.4.0', group: :doc

# Visual Styling
gem 'materialize-sass'

# Image handling
gem 'cloudinary'
gem 'attachinary'

# Maps
gem 'google_visualr'
gem 'geocoder'

# Authentication
gem 'devise'
gem 'omniauth-facebook'

# Security updates
# gem "rack", ">= 2.1.4"

group :production do
  gem 'rails_12factor'
end

group :test do
  gem 'simplecov', '< 0.18', require: false
  # gem 'codecov', require: false
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'byebug'
  gem 'rspec-rails', '~> 3.9'
  gem 'factory_bot_rails'
  gem 'awesome_print'
  gem 'pry'
  gem 'pry-rails'
  gem 'better_errors'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # gem 'spring'
  # gem 'letter_opener'
  gem 'foreman'
  gem 'guard-rspec', require: false
end

