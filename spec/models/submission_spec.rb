require 'rails_helper'

RSpec.describe Submission, type: :model do
   subject {
    exercise = Exercise.new(title: 'test-title', description: 'test-description', test: 'test')
    described_class.new(
      content: 'test-content',
      exercise: exercise
    )
   }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without an exercise" do
    subject.exercise = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without content" do
    subject.content = nil
    expect(subject).to_not be_valid
  end
end
