class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(name: params[:name]).try(:authenticate, params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to admin_posts_path
    else
      flash[:notice] = "Invalid credentials"
      redirect_to login_path
    end
  end
end