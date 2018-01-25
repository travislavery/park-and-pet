class OwnersController < ApplicationController
	get '/owners' do
	  erb :'owners/owners'
	end

	get '/owners/new' do
	  if logged_in?
	  	flash[:message] = "You are already logged in, log out to create a new owner."
	  	redirect "/owners/#{session[:owner_id]}"
	  else
	  	erb :'/owners/new'
	  end
	end

	get '/owners/:id' do
	  @owner = Owner.find(params[:id])
	  erb :'owners/profile'
	end

	get '/owners/:id/edit' do
		need_login?
		@owner = Owner.find(params[:id])
		if @owner.id == session[:owner_id]
			erb :'owners/edit'
		else
			flash[:message] = "You don't have permission to edit that!"
			redirect "/owners/#{params[:id]}"
		end
	end

	patch '/owners/:id' do
		@owner = Owner.find(params[:id])
		if @owner.id == session[:owner_id]
			@owner.update(params[:owner])
		else
			flash[:message] = "You don't have permission to edit that!"
			redirect "/owners/#{params[:id]}"
		end
	end

	delete '/owners/:id' do
		@owner = Owner.find(params[:id])
		if @owner.id == session[:owner_id]
			@owner.pets.each do |pet|
			  pet.owner = Owner.find_by_name("The Pound Guy")
			end
			@owner.delete
		else
			flash[:message] = "You don't have permission to delete that!"
			redirect "/owners/#{params[:id]}"
		end
	end

	post '/owners/new' do
		need_login?
		@owner = Pet.create(params[:peet])
		@owner.owner = Owner.find(session[:owner_id])
		@owner.save
		flash[:message] = "Pet created successfully!"
		redirect "/owners/#{@pet.id}"
	end
end