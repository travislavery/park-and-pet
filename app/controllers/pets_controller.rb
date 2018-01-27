class PetsController < ApplicationController

	get '/pets' do
	  erb :'pets/pets'
	end

	get '/pets/new' do
	  need_login?
	  erb :'pets/new'
	end

	get '/pets/adopt_all' do
		need_login?
		erb :'pets/adopt_all'
	end

	get '/pets/:slug' do
	  @pet = Pet.find_by_slug(params[:slug])
	  erb :'pets/show'
	end

	get '/pets/:slug/edit' do
		need_login?
		@pet = Pet.find_by_slug(params[:slug])
		@owner = Owner.find(session[:owner_id])
		if has_permission?(@pet)
			erb :'pets/edit'
		else
			flash[:message] = "You don't have permission to edit that!"
			redirect "/pets/#{params[:slug]}"
		end
	end

	get '/pets/adopt/:slug' do
		need_login?
		@pet = Pet.find_by_slug(params[:slug])
		if @pet.adoptable
			erb :'pets/adopt'
		else
			flash[:message] = "#{@pet.name} is not up for adoption! Perhaps you'd like to adopt one of these guys!"
			redirect "/pets/adopt_all"
		end
	end

	patch '/pets/adopt/:id' do
		@pet = Pet.find(params[:id])
		if @pet.adoptable
			@pet.owner = Owner.find(session[:owner_id])
			@pet.adoptable = false
			@pet.save
			flash[:message] = "You adopted #{@pet.name}!"
			redirect "/pets/#{@pet.slug}"
		else
			flash[:message] = "#{@pet.name} is not up for adoption! Perhaps you'd like to adopt one of these guys!"
			redirect "/pets/adopt_all"
		end
	end
	patch '/pets/:id' do
		need_login?
		@pet = Pet.find(params[:id])
		if has_permission?(@pet)
			if params[:adoptable] != "none"
				@pet.update(adoptable: params[:adoptable])
			end
			@pet.update(params[:pet])
			flash[:message] = "#{@pet.name} updated successfully!"
			redirect "/pets/#{@pet.slug}"
		else
			flash[:message] = "You don't have permission to edit that!"
			redirect "/pets/#{@pet.slug}"
		end
	end

	delete '/pets/:slug/delete' do
		need_login?
		@pet = Pet.find_by_slug(params[:slug])
		if has_permission?(@pet)
			flash[:message] = "#{@pet.name} deleted."
			@pet.delete
			redirect "/"
		else
			flash[:message] = "You don't have permission to delete that!"
			redirect "/pets/#{params[:id]}"
		end
	end

	post '/pets/new' do
		need_login?
		@pet = Pet.create(params[:pet])
		@pet.owner = Owner.find(session[:owner_id])
		@pet.park = Park.find_by_name("Doggo Hospital")
		@pet.save
		flash[:message] = "Pet created successfully!"
		redirect "/pets/#{@pet.slug}"
	end

	post '/pets/transfer' do
		@pet = Pet.find(params[:pet])
		@pet.park = Park.find(params[:park])
		@pet.save
		redirect "/parks/#{Park.find(params[:park]).slug}"
	end
end