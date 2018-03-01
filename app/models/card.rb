class Card < ApplicationRecord
  validates_presence_of :front, :back
end
