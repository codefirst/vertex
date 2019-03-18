source 'https://rubygems.org'
ruby '2.5.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2.2.1'

# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]


group :development, :test do
  gem "rspec-rails"
end

gem 'thin'
gem "slim-rails"
gem "devise"
gem "omniauth"
gem "omniauth-twitter"
gem "omniauth-github"
gem 'simple_token_authentication', '~> 1.0'
gem "dotenv-rails"
gem "bootstrap-sass", "3.4.1"
gem "font-awesome-rails"
gem 'ranked-model'
gem 'jquery-ui-rails'
gem 'best_in_place'
gem 'chrono_cross', :github => 'mallowlabs/chrono_cross'
#gem 'newrelic_rpm'
gem 'bootsnap', require: false

group :development, :test do
  gem 'sqlite3', '~> 1.3.6'
  #gem 'quiet_assets'
  gem 'listen'
  gem 'rb-readline'
end

group :production do
  gem 'pg'
end

