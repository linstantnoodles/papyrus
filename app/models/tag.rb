class Tag < ApplicationRecord
  validates_presence_of :name
  has_many :taggings
  has_many :taggables, through: :taggings
  before_save { self.name = self.name.downcase }
end
