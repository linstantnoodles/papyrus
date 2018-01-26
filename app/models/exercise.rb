class Exercise < ApplicationRecord
  validates_presence_of :title, :description, :test
  has_many :submissions
end
