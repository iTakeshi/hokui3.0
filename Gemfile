source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.5'

group :test, :development do
  gem 'sqlite3'
end

group :production do
  gem 'mysql2'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'less-rails', '2.3.3'
  gem 'coffee-rails', '~> 4.0.0'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', platforms: :ruby

  gem 'uglifier', '>= 1.3.0'
end

gem 'jquery-rails'

gem 'twitter-bootstrap-rails', '2.2.6'

gem 'i18n_generators'

gem 'kaminari'

gem 'gmail'
gem 'mail'

gem 'whenever', require: false

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 1.0.1'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano', '~> 2.0', group: :development

# To use debugger
# gem 'debugger', group: [:development, :test]

group :development do
  gem 'pry-rails'
  gem 'better_errors'
  gem 'binding_of_caller'
end
