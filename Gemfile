source 'https://rubygems.org'

# Declare your gem's dependencies in api_flashcards.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]
gem "active_model_serializers", "~> 0.10.0"
gem "responders"

group :development do
  gem 'yard'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'rubocop'
  gem 'sqlite3'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'json_spec'
  gem 'levenshtein'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
end
