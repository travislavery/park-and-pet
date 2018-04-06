ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
	ENV['DATABASE_URL'] || 'postgres://localhost/mydb'
	# :adapter => "postgresql",
	# :database => "#{ENV['SINATRA_ENV']}",
	# :host => "localhost",
	# :username => "testuser",
	# :password => "test123"
)

require_all 'app'