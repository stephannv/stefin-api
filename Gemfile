source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'bootsnap', '1.4.4', require: false
gem 'pg', '1.1.4'
gem 'puma', '3.12.1'
gem 'rack-cors', '1.0.3'
gem 'rails', '6.0.0.rc2'
gem 'tzinfo-data', '1.2.5', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'awesome_print', '1.8.0'
  gem 'byebug', '11.0.1', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '5.0.2'
  gem 'faker', '2.1.0'
  gem 'rspec-rails', '3.8.2'
  gem 'rubocop', '0.74.0'
  gem 'rubocop-performance', '1.4.1'
  gem 'rubocop-rails', '2.2.1'
end

group :development do
  gem 'listen', '3.1.5'
  gem 'spring', '2.1.0'
  gem 'spring-watcher-listen', '2.0.1'
end

group :test do
  gem 'shoulda-matchers', '4.1.2'
  gem 'simplecov', '0.17.0'
end
