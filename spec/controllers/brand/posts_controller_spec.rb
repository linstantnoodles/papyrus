require 'rails_helper'

RSpec.describe Brand::PostsController, :type => :controller do
  describe 'index' do
    it 'returns published posts only' do
      draft_post = Post.create(title: 'test-title', content: 'test-content', stage: Post::Stages::DRAFT)
      published_post = Post.create(title: 'test-title', content: 'test-content', stage: Post::Stages::PUBLISHED)

      get :index

      expect(assigns(:posts)).to eq([published_post])
    end

    it 'returns published posts in descending order by publish date' do
      post_published_now = Post.create(title: 'test-title', content: 'test-content', stage: Post::Stages::PUBLISHED, published_at: Time.now)
      post_published_yesterday = Post.create(title: 'test-title', content: 'test-content', stage: Post::Stages::PUBLISHED, published_at: 1.day.ago)
      post_published_last_week = Post.create(title: 'test-title', content: 'test-content', stage: Post::Stages::PUBLISHED, published_at: 1.week.ago)

      get :index

      expect(assigns(:posts)).to eq([post_published_now, post_published_yesterday, post_published_last_week])
    end
  end

  describe 'show' do
    context 'when attempting to view draft post' do
      it 'returns 404' do
        post = Post.create(title: 'test title', content: 'test-content', stage: Post::Stages::DRAFT)

        get :show, params: {
          slug: 'test-title'
        }

        expect(response).to have_http_status(404)
      end
    end

    context 'when attempting to view published post' do
      context 'when visiting it by title slug' do
        it 'returns 200' do
          post = Post.create(title: 'test title', content: 'test-content', stage: Post::Stages::PUBLISHED)

          get :show, params: {
            slug: 'test-title'
          }

          expect(response).to have_http_status(200)
        end
      end
    end
  end
end