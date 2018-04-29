class Card < ApplicationRecord
  include SpacedRepetition

  validates_presence_of :front, :back
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
end
