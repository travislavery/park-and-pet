require_relative './config/environment'
require 'sinatra/activerecord/rake'
require 'database_cleaner'

task :console do
	Pry.start
end

task :clear_db do
	DatabaseCleaner.clean
end