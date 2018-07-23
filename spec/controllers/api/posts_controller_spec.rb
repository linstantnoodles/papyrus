require 'rails_helper'

describe Api::PostsController, type: :controller do
  describe '#create' do
    context 'when params are correct' do
      it 'creates a new post' do
        post :create, params: {
          title: 'sup',
          content: 'test',
          tags: 'til',
          stage: Post::Stages::DRAFT
        }

        created_post = Post.first
        expect(created_post.title).to eq('sup')
        expect(created_post.content).to eq('test')
        expect(created_post.tagged_with?(['til'])).to eq(true)
        expect(created_post.stage).to eq(Post::Stages::DRAFT)
      end

      it 'returns 201 created JSON with id' do
        response = post :create, params: {
          title: 'sup',
          content: 'test',
          tags: 'til',
          stage: Post::Stages::DRAFT
        }

        expect(response.code).to eq('201')
        expect(response.body).to eq({'id': Post.first.id}.to_json)
      end
    end
  end
end