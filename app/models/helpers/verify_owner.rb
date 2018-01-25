module VerifyOwner
	def logged_in?
		not session[:owner_id].nil?
	end

	def current_user
		Owner.find(session[:owner_id])
	end
end