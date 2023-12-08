class SessionsController < ApplicationController

  def new

  end


  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      log_in!(@user)
      redirect_to users_dashboard_path
    else
      flash[:errors] = ["Invalid Credentials"]
      redirect_to new_session_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

end