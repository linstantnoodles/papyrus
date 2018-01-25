class Submission < ApplicationRecord
  validates_presence_of :content
  belongs_to :exercise
end
