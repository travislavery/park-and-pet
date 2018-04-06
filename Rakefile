require_relative './config/environment'
#set :database, {adapter: 'postgresql', encoding: 'unicode', database: 'development', pool: 2}
require 'sinatra/activerecord/rake'
require 'database_cleaner'

task :console do
	Pry.start
end

task :clear_db do
	DatabaseCleaner.clean
end