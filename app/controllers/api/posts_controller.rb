module Api
  class PostsController < ApplicationController
    skip_before_filter :verify_authenticity_token

    def create
      @post = Post.new(
        title: params[:title],
        content: params[:content],
        stage: params[:stage]
      )
      if @post.save && @post.update(tags: tags)
        render :json => { :id => @post.id }, :status => 201
      end
    end

    def tags
      return [] unless !params[:tags].blank?
      params[:tags].split(',').map {
        |name| Tag.find_or_create_by(name: name.strip)
      }
    end
  end
end