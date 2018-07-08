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

  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  validates_presence_of :title, :content
  validates_presence_of :stage
  validates :stage, inclusion: { in: Stages.all, message: "%{value} is not a valid stage" }

  after_initialize :set_default_stage, if: :new_record?
  before_save :check_parent_post

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

  def tagged_with?(tag_name)
    tags.any? { |tag| tag.name == tag_name }
  end

  private

    def set_default_stage
      self.stage ||= Stages::DRAFT
    end

    def check_parent_post
      if (is_self? || is_a_descendent?)
        errors.add(:post_id, :parent_is_descendent, message: 'parent must not be descendent')
        throw :abort
      else
        true
      end
    end

    def is_a_descendent?
      descendent_posts.include? parent_post
    end

    def is_self?
      parent_post&.id == id unless (parent_post&.id.nil? || id.nil?)
    end

  protected

    def descendent_posts
      children = []
      children += Post.where(post_id: id).to_a unless id.nil?
      descendents = []
      children.each do |post|
        descendents += post.descendent_posts
      end
      children + descendents
    end
end
