module Admin
  class StatisticsController < BaseController
    def index
      @posts = Post.all
      @last_published_post = Post.all.order('published_at DESC').select(&:published?).first
    end
  end
end
