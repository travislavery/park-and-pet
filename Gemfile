source 'http://rubygems.org'

gem 'sinatra'
gem 'activerecord', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rake'
gem 'require_all'
gem 'bcrypt'
gem 'rack-flash3'
gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'

group :development do 
	gem 'sqlite3'
	gem 'tux'
	gem 'shotgun'
	gem 'pry'
end

group :production do
	gem 'pg', "~> 0.18"
end
