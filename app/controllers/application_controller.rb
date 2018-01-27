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

	get '/logout' do
		session.clear
		redirect '/'
	end

	get '/signup' do
	  if logged_in?
	  	flash[:message] = "You are already logged in, log out to create a new owner."
	  	redirect "/owners/#{session[:owner_id]}"
	  else
	  	erb :'/owners/new'
	  end
	end

	get '/login' do
	  if logged_in?
	  	flash[:message] = "You are already logged in."
	  	redirect "/"
	  else
	  	erb :'/owners/login'
	  end
	end

  post '/signup' do
  	@owner = Owner.new(params[:owner])
  	if @owner.save
  		@owner.save
  		session[:owner_id] = @owner.id
  		redirect to '/'
  	else
  		error = @owner.errors.messages.map {|attribute, msg| "#{attribute.to_s} #{msg[0]}"}
  		flash[:message] = "#{error.each {|e| e[0]}}"
  		redirect '/signup'
  	end
  end

  post '/login' do
  	@owner = Owner.find_by_username(params[:username])
  	if @owner && @owner.authenticate(params[:password])
  		session[:owner_id] = @owner.id
  		flash[:message] = "Logged in successfully!"
  		redirect '/'
  	else
  		flash[:message] = "Unable to log in with that username and password."
  		redirect '/login'
  	end
  end

end