class OwnersController < ApplicationController
	get '/owners' do
	  erb :'/owners/owners'
	end

	get '/owners/:slug' do
	  @owner = Owner.find_by_slug(params[:slug])
	  erb :'/owners/profile'
	end

	get '/owners/:slug/pets' do
		@owner = Owner.find_by_slug(params[:slug])
		erb :'/owners/pets'
	end

	get '/owners/:slug/parks' do
		@owner = Owner.find_by_slug(params[:slug])
		erb :'/owners/parks'
	end


	get '/owners/:slug/edit' do
		need_login?
		@owner = Owner.find_by_slug(params[:slug])

		if current_user?
			erb :'/owners/edit'
		else
			flash[:message] = "You don't have permission to edit that!"
			redirect "/owners/#{params[:slug]}"
		end
	end

	get '/owners/:slug/change-password' do
		need_login?
		@owner = Owner.find_by_slug(params[:slug])
		if current_user?
			erb :'owners/password'
		else
			flash[:message] = "You don't have permission to change that!"
			redirect "/owners/#{params[:slug]}"
		end
	end

	patch '/owners/:id' do
		@owner = Owner.find(params[:id])
		if current_user?
			if params[:pound]
				params[:pound][:pets].each do |pet|
					animal = Pet.find(pet)
					animal.update(owner: Owner.find_by_username("The Pound Guy"), park: Park.find_by_name("The Pound"), adoptable: "true")
				end
			end
			if @owner.errors.any?
				error = @owner.errors.messages.map {|attribute, msg| "#{attribute.to_s} #{msg[0]}"}
  				flash[:message] = "#{error.each {|e| e[0]}}"
  			else
  				flash[:message] = "Sucessfully updated profile!"
  			end
			redirect "/owners/#{@owner.slug}"
		else
			flash[:message] = "You don't have permission to edit that!"
			redirect "/owners/#{@owner.slug}"
		end
	end

	patch '/owners/:id/password' do
		@owner = Owner.find(params[:id])
		if current_user?
			@owner.update(params[:user])
			if @owner.errors.any?
				error = @owner.errors.messages.map {|attribute, msg| "#{attribute.to_s} #{msg[0]}"}
  				flash[:message] = "#{error.each {|e| e[0]}}"
  			else
  				flash[:message] = "Sucessfully updated username and password!"
  			end
			redirect "/owners/#{@owner.slug}"
		else
			flash[:message] = "You don't have permission to edit that!"
			redirect "/owners/#{@owner.slug}"
		end
	end

	delete '/owners/:id' do
		@owner = Owner.find(params[:id])
		if current_user?
			@owner.pets.each do |pet|
			  pet.owner = Owner.find_by_name("The Pound Guy")
			  pet.park = Park.find_by_name("The Pound")
			end
			@owner.parks.each do |park|
			  park.owner = Owner.find_by_name("The Hospital Guy")
			end
			flash[:message] = "#{@owner.username} deleted."
			@owner.delete
			redirect "/logout"
		else
			flash[:message] = "You don't have permission to delete that!"
			redirect "/owners/#{@owner.slug}"
		end
	end

end