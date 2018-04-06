ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

configure :development do
	set :database, "sqlite3:db/#{ENV['SINATRA_ENV']}"#'sqlite3://dev.db'
	set :show_exceptions, true
end

configure :production do
	db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')

	ActiveRecord::Base.establish_connection(
		:adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
		:host => db.host,
		:username => db.user,
		:password => db.password,
		:database => db.path[1..-1],
		:encoding => 'utf8'
	)
end



# ActiveRecord::Base.establish_connection(
# 	ENV['DATABASE_URL'] || 'postgres://localhost/mydb'
# )

require_all 'app'