module Brand
  class PostsController < ApplicationController
    layout 'brand'

    def index
      @posts = Post.includes(:tags).where(stage: Post::Stages::PUBLISHED).order('published_at DESC').select { |post| !post.tagged_with?('til') }
    end

    def show
      @post = PostDecorator.new(post: Post.find_by!(slug: params[:slug], stage: Post::Stages::PUBLISHED))
    end

    def preview
      @post = PostDecorator.new(post: Post.find_by!(slug: params[:slug]))
    end
  end
end