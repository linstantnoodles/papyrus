require 'rails_helper'

RSpec.describe Admin::PostsController, :type => :controller do
  context 'when session does not exist' do
    it 'redirects to posts' do
      get :index
      expect(response).to redirect_to(posts_path)
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
    end

    describe '#create' do
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