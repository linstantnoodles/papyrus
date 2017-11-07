module Brand
  class PostsController < ApplicationController
    layout 'brand'

    def index
      @posts = Post.all.order('created_at DESC')
    end

    def show
      @post = PostDecorator.new(post: Post.find_by_id!(params[:id]))
    end
  end
end