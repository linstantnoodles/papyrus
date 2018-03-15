module Admin
  class PostsController < ApplicationController
    layout 'admin'
    before_action :authenticate

    def index
      @published_posts = Post.all.select(&:published?)
      @draft_posts = Post.order(:created_at).all.reject(&:published?)
    end

    def new
      @post = Post.new(post_id: params[:post_id])
    end

    def show
      @post = PostDecorator.new(post: Post.find_by_id!(params[:id]))
    end

    def edit
      @post = Post.find_by_id!(params[:id])
    end

    def update
      @post = Post.find_by_id!(params[:id])
      if @post.update_attributes(
        title: params[:title],
        content: params[:content],
        post_id: params[:post_id]
      )
        redirect_to admin_posts_path
      else
        render :edit
      end
    end

    def create
      @post = Post.new(title: params[:title], content: params[:content], post_id: params[:post_id])
      if @post.save
        return redirect_to admin_post_path(id: params[:post_id]) unless params[:post_id].blank?
        redirect_to admin_posts_path
      else
        render :new
      end
    end

    def destroy
      @post = Post.find_by_id!(params[:id])
      @post.destroy
      redirect_to admin_posts_path
    end

    def publish
      post = Post.find_by_id!(params[:id])
      post.publish
      post.save
      redirect_to admin_posts_path
    end

    def unpublish
      post = Post.find_by_id!(params[:id])
      post.unpublish
      post.save
      redirect_to admin_posts_path
    end

    def current_user
      @current_user ||= User.find_by_id(session[:user_id])
    end

    def authenticate
      redirect_to login_path unless current_user
    end
  end
end