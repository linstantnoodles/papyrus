class Admin::StatisticsController < ApplicationController
  layout 'admin'

  before_action :authenticate

  def index
    @posts = Post.all
    @last_published_post = Post.all.order('published_at DESC').select(&:published?).first
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def authenticate
    redirect_to login_path unless current_user
  end
end
