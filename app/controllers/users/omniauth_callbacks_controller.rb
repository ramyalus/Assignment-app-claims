class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def google_oauth2
		@user = User.from_omniauth(auth)
		if @user.persisted?
	    flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
		else
			session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
      redirect_to new_user_session_path, alert: "Oops! Something went wrong, Please try after sometime" #@user.errors.full_messages.join("\n")
		end
	end

	private
	def auth
		request.env['omniauth.auth']['info']
	end
end