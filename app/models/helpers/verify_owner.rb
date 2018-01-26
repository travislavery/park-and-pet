module VerifyOwner
	def logged_in?
		not session[:owner_id].nil?
	end

	def current_user?
		if session[:owner_id] == @owner.id
			return true
		else
			return false
		end
	end

	def need_login?
		if !logged_in?
			redirect to "/login"
		end
	end

	def has_permission?(object)
		if object.owner.id == session[:owner_id]
			return true
		else
			return false
		end
	end
end