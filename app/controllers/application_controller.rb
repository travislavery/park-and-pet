class ApplicationController < Sinatra::Base
	include VerifyOwner
	configure do 
		enable :sessions
		set :session_secret, "secret"
		set :views, 'app/views'
	end

	get '/' do
		erb :index
	end
end