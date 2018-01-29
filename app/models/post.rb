class Post < ApplicationRecord
  module Stages
    DRAFT = 'draft'.freeze
    PUBLISHED = 'published'.freeze

    def is_published?
      stage == PUBLISHED
    end
  end
  include Stages
  validates_presence_of :title, :content, :stage
end
