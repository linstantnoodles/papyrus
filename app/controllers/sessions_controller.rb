class SessionsController < ApplicationController
  layout 'admin'
  before_action :authenticate, only: [:new, :create]

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

  def destroy
    session.clear
    redirect_to root_path
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def authenticate
    redirect_to admin_posts_path if current_user
  end
end