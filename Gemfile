source 'https://rubygems.org'

ruby '1.9.3'
gem 'rails', '4.0.1'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use a bumped version to ensure we can use sprockets ~2.10 (for baked in bower support)
gem 'sprockets-commonjs', git: 'https://github.com/carlmw/sprockets-commonjs.git', branch: 'sprockets-2.10-support'

# Please keep this list alphabetised
gem 'bcrypt-ruby', '~> 3.1.2'
gem 'carrierwave'
gem 'compass-rails', git: 'https://github.com/Compass/compass-rails.git', branch: '2-0-stable'
gem 'draper'
gem 'fog'
gem 'font-awesome-rails'
gem 'foundation-rails'
gem 'handlebars_assets', '~> 0.14.1'
gem 'inherited_resources'
gem 'jquery-rails'
gem 'mini_magick'
gem 'neat', '~> 1.4.0'
gem 'pg'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier'
gem 'unf'
gem 'unicorn', '~> 4.6.0'

group :development do
  gem 'annotate'
  gem 'annotations'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'guard-bundler'
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'meta_request'
  gem 'pry-debugger'
  gem 'pwqgen.rb'
  gem 'terminal-notifier-guard'
  gem 'thin'
end

group :test do
  gem 'be_valid_asset'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'machinist'
  gem 'poltergeist'
  gem 'shoulda-matchers'
  gem 'timecop'
end

group :test, :development do
  gem 'dotenv'
  gem 'jasmine-rails', '~> 0.4.9'
  gem 'rspec-rails'

  gem 'pry-remote'

  # We like to use 'pry-plus' but some of its tools do not work with 1.9.3, only with 2.0
  # We list them all here instead, commenting out those that don't work but would rather just have:
  # gem 'pry-plus'

  gem "pry-doc"
  gem "pry-docmore"
  # gem "pry-stack_explorer"
  # gem "pry-rescue"
  # gem "bond"
  # gem "jist"
end

gem 'rails_12factor', group: :production
