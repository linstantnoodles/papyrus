module Brand
  class PagesController < ApplicationController
    layout 'brand'

    def about; end

    def series
      @posts = Post.all.order('published_at DESC').select do |post|
        post.published? && post.series?
      end
    end

    def til
      @posts = Post.all.order('published_at DESC').select do |post|
        post.published? && post.tagged_with?('til')
      end
    end
  end
end