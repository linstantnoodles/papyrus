module Admin
  class PostsController < ApplicationController
    before_action :authenticate

    def index
      @posts = Post.all
    end

    def new
      @post = Post.new
    end

    def show
      @post = PostDecorator.new(post: Post.find_by_id!(params[:id]))
    end

    def edit
      @post = Post.find_by_id!(params[:id])
    end

    def update
      @post = Post.find_by_id!(params[:id])
      if @post.update_attributes(title: params[:title], content: params[:content])
        redirect_to admin_posts_path
      else
        render :edit
      end
    end

    def create
      @post = Post.new(title: params[:title], content: params[:content])
      if @post.save
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

    def authenticate
      redirect_to posts_path unless session[:user_id]
    end
  end
end