module Brand
  class PagesController < ApplicationController
    layout 'brand'
    def about; end
    def series
      @posts = Post.all.order('published_at DESC').select do |post|
        post.published? && post.series?
      end
    end
  end
end