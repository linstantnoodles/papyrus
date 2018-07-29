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

  it "should set published date if stage is published" do
    current_time = Time.now
    allow(Time).to receive(:now).and_return(current_time)
    post = Post.new(
      title: 'test-title',
      content: 'test-content',
      stage: Post::Stages::PUBLISHED
    )
    post.save
    expect(post.published_at).to eq(current_time)
  end

  it "sets slug after save" do
    post = Post.new(
      title: 'test title haha 123',
      content: 'test-content'
    )
    post.save
    expect(post.slug).to eq('test-title-haha-123')
  end

  it "can have many posts" do
    post_series = Post.create(title: 'title of my new series', content: 'about my new series')
    Post.create(title: 'post one', content: 'first post of series', post: post_series)
    Post.create(title: 'post two', content: 'second post of series', post: post_series)

    expect(post_series.posts.count).to be(2)
  end

  context 'adding a parent' do
    context 'when parent is itself' do
      it 'should not save' do
        post = Post.create(title: 'title of my new series', content: 'test')
        post.update(post: post)

        expect(post.errors.full_messages).to_not be_empty
      end
    end

    context 'when parent is a descendent' do
      it 'should not save' do
        post_grandparent = Post.create(title: 'title of my new series', content: 'about my new series')
        post_parent = Post.create(title: 'post two', content: 'second post of series', post: post_grandparent)
        post_child = Post.create(title: 'post three', content: 'child post of series', post: post_parent)

        post_grandparent.update(post: post_child)
        expect(post_grandparent.errors.full_messages).to_not be_empty
      end
    end
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
      post.save
      expect(post.stage).to eq(Post::Stages::PUBLISHED)
    end

    it 'should update published_at date' do
      post = Post.create(
        title: 'test-title',
        content: 'test-content'
      )

      post.publish
      post.save
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

  describe '#tagged_with?' do
    context 'when post has tag' do
      it 'returns true' do
        post = Post.create(
          title: 'test-title',
          content: 'test-content',
          stage: Post::Stages::PUBLISHED
        )

        post.tags.create(name: 'sup')
        expect(post.tagged_with?(['sup'])).to eq(true)
      end
    end

    context 'when post does not have tag' do
      it 'returns false' do
        post = Post.create(
          title: 'test-title',
          content: 'test-content',
          stage: Post::Stages::PUBLISHED
        )

        post.tags.create(name: 'sup')
        expect(post.tagged_with?('yo')).to eq(false)
      end
    end
  end
end

