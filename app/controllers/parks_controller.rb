class ParksController < ApplicationController


	get '/parks' do
	  erb :'parks/parks'
	end

	get '/parks/new' do
	  need_login?
	  erb :'parks/new'
	end

	get '/parks/:slug' do
	  @park = Park.find_by_slug(params[:slug])
	  erb :'parks/show'
	end

	get '/parks/:slug/edit' do
		need_login?
		@park = Park.find_by_slug(params[:slug])
		if has_permission?(@park)
			erb :'parks/edit'
		else
			flash[:message] = "You don't have permission to edit that!"
			redirect "/parks/#{params[:slug]}"
		end
	end

	patch '/parks/:id' do
		need_login?
		@park = Park.find(params[:id])
		if has_permission?(@park)
			@park.update(params[:park])
			flash[:message] = "#{@park.name} updated successfully!"
			redirect "/parks/#{@park.slug}"
		else
			flash[:message] = "You don't have permission to edit that!"
			redirect "/parks/#{@park.slug}"
		end
	end

	delete '/parks/:id' do
		need_login?
		@park = Park.find(params[:id])
		if has_permission?(@park)
			@park.pets.each do |pet|
				pet.park = Park.find_by_name("The Pound")
			end
			flash[:message] = "#{@park.name} deleted."
			@park.delete
			redirect "/"
		else
			flash[:message] = "You don't have permission to delete that!"
			redirect "/parks/#{@park.slug}"
		end
	end

	post '/parks/new' do
		need_login?
		@park = Park.create(params[:park])
		@park.owner = Owner.find(session[:owner_id])
		@park.save
		flash[:message] = "Park created successfully!"
		redirect "/parks/#{@park.slug}"
	end

end