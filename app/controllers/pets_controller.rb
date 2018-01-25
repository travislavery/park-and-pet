class PetsController < ApplicationController

	get '/pets' do
	  erb :'pets/pets'
	end

	get '/pets/new' do
	  need_login?
	  erb :'pets/new'
	end

	get '/pets/:id' do
	  @pet = Pet.find(params[:id])
	  erb :'pets/show'
	end

	get '/pets/:id/edit' do
		need_login?
		@pet = Pet.find(params[:id])
		if has_permission?(@pet)
			erb :'pets/edit'
		else
			flash[:message] = "You don't have permission to edit that!"
			redirect "/pets/#{params[:id]}"
		end
	end

	patch '/pets/:id' do
		need_login?
		@pet = Pet.find(params[:id])
		if has_permission?(@pet)
			@pet.update(params[:pet])
		else
			flash[:message] = "You don't have permission to edit that!"
			redirect "/pets/#{params[:id]}"
		end
	end

	delete '/pets/:id' do
		need_login?
		@pet = Pet.find(params[:id])
		if has_permission?(@pet)
			@pet.delete
		else
			flash[:message] = "You don't have permission to delete that!"
			redirect "/pets/#{params[:id]}"
		end
	end

	post '/pets/new' do
		need_login?
		@pet = Pet.create(params[:pet])
		@pet.owner = Owner.find(session[:owner_id])
		@pet.save
		flash[:message] = "Pet created successfully!"
		redirect "/pets/#{@pet.id}"
	end
end