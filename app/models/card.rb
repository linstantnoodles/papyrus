class Card < ApplicationRecord
  include SpacedRepetition

  validates_presence_of :front, :back
end
