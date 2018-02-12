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

  it "is not valid with an undefined stage" do
    subject.stage = 'not a real stage'
    expect(subject).to_not be_valid
  end

  it "should default to draft if stage is not set" do
    post = Post.new(
      title: 'test-title',
      content: 'test-content'
    )

    expect(post.stage).to eq(Post::Stages::DRAFT)
  end

  it "can have many posts" do
    post_series = Post.create(title: 'title of my new series', content: 'about my new series')
    Post.create(title: 'post one', content: 'first post of series', post: post_series)
    Post.create(title: 'post two', content: 'second post of series', post: post_series)

    expect(post_series.posts.count).to be(2)
  end

  describe '#series?' do
    it 'should return true' do
      post_series = Post.create(title: 'title of my new series', content: 'about my new series')
      Post.create(title: 'post one', content: 'first post of series', post: post_series)

      expect(post_series.series?).to be(true)
    end
  end

  describe '#publish' do
    it 'should update stage to published' do
      post = Post.new(
        title: 'test-title',
        content: 'test-content'
      )

      post.publish
      expect(post.stage).to eq(Post::Stages::PUBLISHED)
    end

    it 'should update published_at date' do
      post = Post.create(
        title: 'test-title',
        content: 'test-content'
      )

      post.publish
      expect(post.published_at).to be > post.created_at
    end
  end

  describe '#unpublish' do
    it 'should update stage to be draft' do
      post = Post.new(
          title: 'test-title',
          content: 'test-content',
          stage: Post::Stages::PUBLISHED
        )

      post.unpublish
      expect(post.stage).to eq(Post::Stages::DRAFT)
    end
  end

  describe '#published?' do
    context 'when post is in draft stage' do
      it 'returns false' do
        subject.stage = Post::Stages::DRAFT
        expect(subject.published?).to eq(false)
      end
    end
    context 'when post is in publish stage' do
      it 'returns true' do
        subject.stage = Post::Stages::PUBLISHED
        expect(subject.published?).to eq(true)
      end
    end
  end
end

