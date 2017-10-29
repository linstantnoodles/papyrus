class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = PostDecorator.new(post: Post.find_by_id!(params[:id]))
  end
end