class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.authenticate(session_params[:email], session_params[:password])
    if user
      session[:user_id] = user.id
      redirect_to profile_path, flash: {success: "You have logged in."}
    else
      flash.now[:error] = "Invalid email or password."
      render "new"
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
