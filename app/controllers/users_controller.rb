class UsersController < ApplicationController
  skip_before_filter :authenticate_user, except: [:show]

  def new

  end

  def show
    @user = current_user
  end

  def create
    user = User.create(user_params)
    if user.valid?
      session[:user_id] = user.id
      redirect_to profile_path, flash: {success: "You have signed up!"}
    else
      flash.now[:error] = "Please fill in all details"
      render "new"
    end

  end

  private
    def user_params
      params.permit(:email,:password, :password_confirmation)
    end

end
