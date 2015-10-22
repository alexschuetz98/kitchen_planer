class UsersController < ApplicationController

	helper_method :users, :user


	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to edit_user_path(@user)
		else
			render :new
		end
	end

	def update
		if user.update(user_params)
			redirect_to users_path
		else
			render :edit
		end
	end

	def destroy
		if user.destroy
			flash[:success] = 'Successfully deleted'
		else
			flash[:error] = user.errors.full_messages.to_sentence
		end
		redirect_to users_path
	end

	private

	def users
		@users ||= User.all
	end

	def user
		@user ||= User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:firstname, :lastname, :email, :employee, :password, :password_confirmation)
	end
end