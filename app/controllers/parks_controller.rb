class ParksController < ApplicationController


	get '/parks' do
	  erb :'parks/parks'
	end

	get '/parks/new' do
	  need_login?
	  erb :'parks/new'
	end

	get '/parks/:id' do
	  @park = Park.find(params[:id])
	  erb :'parks/show'
	end

	get '/parks/:id/edit' do
		need_login?
		@park = Park.find(params[:id])
		if has_permission?(@park)
			erb :'parks/edit'
		else
			flash[:message] = "You don't have permission to edit that!"
			redirect "/parks/#{params[:id]}"
		end
	end

	patch '/parks/:id' do
		need_login?
		@park = Park.find(params[:id])
		if has_permission?(@park)
			@park.update(params[:park])
		else
			flash[:message] = "You don't have permission to edit that!"
			redirect "/parks/#{params[:id]}"
		end
	end

	delete '/parks/:id' do
		need_login?
		@park = Park.find(params[:id])
		if has_permission?(@park)
			@park.delete
		else
			flash[:message] = "You don't have permission to delete that!"
			redirect "/parks/#{params[:id]}"
		end
	end

	post '/parks/new' do
		need_login?
		@park = Park.create(params[:park])
		@park.owner = Owner.find(session[:owner_id])
		@park.save
		flash[:message] = "Park created successfully!"
		redirect "/parks/#{@park.id}"
	end

end