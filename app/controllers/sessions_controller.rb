class SessionsController < ApplicationController
  
  def new
    
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] ="You have successfully logged in"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "There was an issue with your login information, try again"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

end