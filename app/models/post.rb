class Post < ApplicationRecord
  module Stages
    DRAFT = 'draft'.freeze
    PUBLISHED = 'published'.freeze

    def published?
      stage == PUBLISHED
    end
  end

  include Stages
  validates_presence_of :title, :content, :stage

  after_initialize :set_default_stage, if: :new_record?

  private

    def set_default_stage
      self.stage ||= Stages::DRAFT
    end
end
