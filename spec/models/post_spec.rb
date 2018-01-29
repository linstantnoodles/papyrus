require 'rails_helper'

RSpec.describe Post, :type => :model do
   subject {
    described_class.new(
      title: 'test-title',
      content: 'test-content',
      stage: Post::Stages::DRAFT
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

  it "is not valid without a stage" do
    subject.stage = nil
    expect(subject).to_not be_valid
  end

  describe 'is_published?' do
    context 'when post is in draft stage' do
      it 'returns false' do
        subject.stage = Post::Stages::DRAFT
        expect(subject.is_published?).to eq(false)
      end
    end
    context 'when post is in publish stage' do
      it 'returns true' do
        subject.stage = Post::Stages::PUBLISHED
        expect(subject.is_published?).to eq(true)
      end
    end
  end
end

