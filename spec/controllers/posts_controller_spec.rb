require 'rails_helper'

RSpec.describe PostsController, :type => :controller do
  describe '#show' do
   it 'it renders the post' do
      my_post = Post.new(title: 'test-title', content: 'test-content')
      my_post.save
      post :show, params: {
        'id' => my_post.id
      }

      expect(assigns(:post)).to eq(my_post)
    end
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
        expect(response).to redirect_to(posts_path)
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

      expect(response).to redirect_to(posts_path)
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
end