require 'rails_helper'

RSpec.describe PostDecorator do

  describe '#title' do
    it 'returns capitalized title' do
      post = Post.new(title: 'test-title', content: 'test-content')
      decorated_post = PostDecorator.new(post: post)

      expect(decorated_post.title).to eq('Test-title')
    end
  end

  describe '#content' do
    it 'returns formatted content' do
      post = Post.new(title: 'test-title', content: 'test-content')
      decorated_post = PostDecorator.new(post: post)
      allow(decorated_post).to receive(:render_as_markdown)

      decorated_post.content

      expect(decorated_post).to have_received(:render_as_markdown).with(post.content)
    end
  end

  describe '#MyHTML.lexer_name' do
    it 'returns the correct lexer constant' do
      expect(PostDecorator::MyHTML.lexer_name('python')).to eq('Python')
    end
  end
end