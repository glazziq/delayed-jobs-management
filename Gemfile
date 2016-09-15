source 'https://rubygems.org'
source 'https://rails-assets.org'

# Declare your gem's dependencies in delayed_jobs_management.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]
gem 'rails', '4.2.0'
gem 'pg'
gem 'puma'
gem 'sass-rails'

# Background jobs
gem 'delayed_job_active_record'
gem 'delayed_job_recurring'

group :development, :test do
  # RSpec
  gem 'rspec-rails', '~> 3.4'
  gem 'factory_girl_rails', '4.5.0'
  gem 'guard-rspec', require: false
  gem 'spring-commands-rspec'

  # Dev / Testing tools
  gem 'pry-rails', '0.3.4'
  gem 'pry-byebug', '3.1.0'

  gem 'database_cleaner', '1.4.1'

  gem 'guard-livereload', '~> 2.5', require: false # automatically reload your browser when 'view' files are modified.
end
