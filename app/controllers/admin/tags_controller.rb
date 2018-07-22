module Admin
  class TagsController < BaseController
    def index
      @tags = Tag.all
    end
  end
end
