source 'https://rubygems.org'

ruby '3.2.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 7.1.2'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '>= 4.0.1'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem 'kredis'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'bcrypt', '~> 3.1.7'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem 'image_processing', '~> 1.2'

# ActiveModelSerializers brings convention over configuration to your JSON generation. [https://github.com/rails-api/active_model_serializers/tree/0-10-stable]
gem 'active_model_serializers'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
gem 'rack-cors'

# A JSON web token(JWT) is a JSON Object that is used to securely transfer information between two parties.
gem 'jwt'

# API that can describe itself in Swagger
gem 'rswag'

# add admin panel
gem 'administrate'

# add access rights
gem 'pundit'

# pagination https://ddnexus.github.io/pagy/
gem 'pagy'

# Provides higher-level image processing helpers that are commonly needed when handling image uploads.
gem 'image_processing', '>= 1.2'

# Active Storage Validation https://github.com/igorkasyanchuk/active_storage_validations
gem 'active_storage_validations'

# for soft delete DB
# gem 'paranoia', '~> 2.6'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows]

  # Add tests
  gem 'rspec-rails', '~> 6.1.0'

  # Faker helps you generate realistic test data
  gem 'ffaker'

  # factory_bot_rails is a fixtures replacement with a straightforward definition syntax
  gem 'factory_bot_rails'

  # check test coverage
  gem 'simplecov', require: false, group: :test
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem 'spring'

  # check n+n queries
  gem 'bullet'
end
