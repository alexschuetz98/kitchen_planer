class UserSessionsController < ApplicationController
	
	skip_before_action :require_login, except: [:destroy]

	def new
		@user = User.new
	end

	def create
		if @user = login(params[:user_session][:email], params[:user_session][:password])
			redirect_back_or_to (:users)
		else
			flash.now[:alert] = 'login failed'
			render :new
		end
	end

	def destroy
		logout
		redirect_to(:users, notice: 'logged out')
	end
end