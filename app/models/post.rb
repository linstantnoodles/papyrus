class Post < ApplicationRecord
  module Stages
    DRAFT = 'draft'.freeze
    PUBLISHED = 'published'.freeze

    def self.all
      [DRAFT, PUBLISHED]
    end

    def published?
      stage == PUBLISHED
    end
  end

  include Stages
  validates_presence_of :title, :content
  validates_presence_of :stage
  validates :stage, inclusion: { in: Stages.all, message: "%{value} is not a valid stage" }

  after_initialize :set_default_stage, if: :new_record?

  def publish
    self.stage = Stages::PUBLISHED
    self.published_at = Time.now
  end

  private

    def set_default_stage
      self.stage ||= Stages::DRAFT
    end
end
