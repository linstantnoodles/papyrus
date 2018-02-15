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

  has_many :posts
  belongs_to :post, optional: true
  alias_attribute :child_posts, :posts
  alias_attribute :parent_post, :post

  validates_presence_of :title, :content
  validates_presence_of :stage
  validates :stage, inclusion: { in: Stages.all, message: "%{value} is not a valid stage" }

  after_initialize :set_default_stage, if: :new_record?

  def publish
    self.stage = Stages::PUBLISHED
    self.published_at = Time.now
  end

  def unpublish
    self.stage = Stages::DRAFT
  end

  def series?
    posts.present?
  end

  private

    def set_default_stage
      self.stage ||= Stages::DRAFT
    end
end
