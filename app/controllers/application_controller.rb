require 'sinatra/base'
require 'rack-flash'
class ApplicationController < Sinatra::Base
	include VerifyOwner
	configure do 
		enable :sessions
		use Rack::Flash
		set :session_secret, "secret"
		set :views, 'app/views'
	end

	get '/' do
		erb :index
	end
end