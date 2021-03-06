module SessionsHelper

	def sign_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.digest(remember_token))
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		remember_token = User.digest(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
	end

	def current_user?(user)
		user == current_user
	end

	#moved from users_controller for microposts_controller / relationships_controller
	def signed_in_user #construction 'notice:' doesn’t work for the :error or :success keys.
    unless signed_in?
	    store_location
	    redirect_to signin_url, notice: "Please Sign in."
	                    #flash[:notice] = "Please sign in."
   	end
  end

	def sign_out
		current_user.update_attribute(:remember_token, User.digest(User.new_remember_token))
		cookies.delete(:remember_token)
		#self.current_user = nil #optional - if sign_out (in session_controller) without redirect
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default )
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url if request.get?
	end

	def show_button?
		session[:show_button]
		session.delete(:show_button)
	end

	def button?( x = 'hide')
		if x == 'hide'
			session[:show_button] = false
		else
			session[:show_button] = true
		end
	end

end
