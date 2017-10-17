require 'rails_helper'

RSpec.describe Post, :type => :model do
   subject {
    described_class.new(
      title: 'test-title',
      content: 'test-content'
    )
   }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a content" do
    subject.content = nil
    expect(subject).to_not be_valid
  end
end

