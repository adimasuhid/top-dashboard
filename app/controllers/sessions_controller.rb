class SessionsController < ApplicationController
  skip_before_filter :authenticate_user

  def new

  end

  def create
    user = User.authenticate(session_params[:email], session_params[:password])
    if user
      session[:user_id] = user.id
      redirect_to profile_path, flash: {success: "You have logged in."}
    else
      redirect_to sign_in_path, flash: {error: "Invalid email or password."}
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, flash: {success: "You have logged out."}
  end

  private
    def session_params
      params.permit(:email,:password)
    end

end
