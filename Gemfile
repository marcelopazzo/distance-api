source 'https://rubygems.org'
ruby "2.2.1" unless ENV['CI']

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'pry-rails', '~> 0.3.3'
  gem 'sqlite3'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :development do
  gem 'guard', '~> 2.12.4'
  gem 'guard-rspec', '~> 4.5.0', require: false
  gem 'guard-bundler', '~> 2.1.0'
  gem 'guard-minitest', '~> 2.4.4'
end

group :test do
  gem 'minitest-reporters', '~> 1.0.11'
end

group :production do
  gem 'pg', '~> 0.18.1'
  gem 'rails_12factor', '~> 0.0.3'
  gem 'unicorn', '~> 4.8.3'
end

gem 'rails-api', '~> 0.4.0'
gem 'active_model_serializers', '~> 0.9.3'
gem 'PriorityQueue', '~> 0.1.2'