require 'rails_helper'

RSpec.describe Admin::PostsController, :type => :controller do
  context 'when session does not exist' do
    it 'redirects to posts' do
      get :index
      expect(response).to redirect_to(login_path)
    end
  end

  context 'when session exists' do
    before(:each) do
      user = User.create(name: 'admin', password: 'password')
      session[:user_id] = user.id
    end

    describe '#update' do
      context 'when params valid' do
        it 'redirects to index' do
          my_post = Post.new(title: 'test-title', content: 'test-content')
          my_post.save
          post :update, params: {
            'id' => my_post.id,
            'title' => 'new title',
            'content' => 'test content'
          }

          expect(my_post.reload.title).to eq('new title')
          expect(response).to redirect_to(admin_posts_path)
        end
      end

      context 'when params invalid' do
        it 'renders edit' do
          my_post = Post.new(title: 'test-title', content: 'test-content')
          my_post.save
          post :update, params: {
            'id' => my_post.id,
            'title' => '',
            'content' => ''
          }

          expect(response).to render_template(:edit)
        end
      end

      context 'when tags exists' do
        it 'updates post with tags' do
          my_post = Post.create(title: 'test-title', content: 'test-content')
          post :update, params: {
            'id' => my_post.id,
            'title' => 'wow',
            'content' => 'test content',
            'tags' => 'tag1, tag2'
          }

          my_post = my_post.reload
          expect(my_post.tags.size).to eq(2)
          expect(my_post.tags.first.name).to eq('tag1')
          expect(my_post.tags.second.name).to eq('tag2')
        end
      end
    end

    describe '#create' do
      context 'when post id exists' do
        it 'creates a new child post' do
          parent_post = Post.create(title: 'test-title', content: 'test-content')
          post :create, params: {
            'title' => 'child title',
            'content' => 'test content',
            'post_id' => parent_post.id
          }

          expect(parent_post.reload.posts.first.title).to eq('child title')
        end

        it 'redirects to parent post' do
          parent_post = Post.create(title: 'test-title', content: 'test-content')
          post :create, params: {
            'title' => 'child title',
            'content' => 'test content',
            'post_id' => parent_post.id
          }

          expect(response).to redirect_to(admin_post_path(id: parent_post.id))
        end
      end

      it 'creates a new post' do
        post :create, params: {
          'title' => 'test title',
          'content' => 'test content'
        }

        expect(Post.count).to eq(1)
      end

      it 'redirects to #index' do
        response = post :create, params: {
          'title' => 'test title',
          'content' => 'test content'
        }

        expect(response).to redirect_to(admin_posts_path)
      end

      context 'missing required fields' do
        it 'renders new' do
          response = post :create, params: {
            'title' => '',
            'content' => 'test content'
          }

          expect(response).to render_template(:new)
        end
      end

      context 'when tag exists' do
        it 'creates new card with tags' do
          post :create, params: {
            'title' => 'wow',
            'content' => 'test content',
            'tags' => 'tag1, tag2'
          }

          expect(Post.first.tags.size).to eq(2)
          expect(Post.first.tags.first.name).to eq('tag1')
          expect(Post.first.tags.second.name).to eq('tag2')
        end
      end
    end

    describe '#publish' do
      it 'publishes the post' do
          my_post = Post.new(title: 'test-title', content: 'test-content')
          my_post.save
          get :publish, params: {
            'id' => my_post.id
          }

          expect(my_post.reload.stage).to eq(Post::Stages::PUBLISHED)
          expect(response).to redirect_to(admin_posts_path)
      end
    end

    describe '#unpublish' do
      it 'unpublishes the post' do
        my_post = Post.new(title: 'test-title', content: 'test-content')
        my_post.save
        get :unpublish, params: {
          'id' => my_post.id
        }

        expect(my_post.reload.stage).to eq(Post::Stages::DRAFT)
        expect(response).to redirect_to(admin_posts_path)
      end
    end

    describe '#destroy' do
      it 'redirects to index' do
          my_post = Post.new(title: 'test-title', content: 'test-content')
          my_post.save
          post :destroy, params: {
            'id' => my_post.id
          }
          expect(response).to redirect_to(admin_posts_path)
      end
    end
  end
end