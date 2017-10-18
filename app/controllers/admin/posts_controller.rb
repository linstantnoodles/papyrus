require 'rouge'
require 'rouge/plugins/redcarpet'

module Admin
  class PostsController < ApplicationController
    def index
      @posts = Post.all
    end

    def new
      @post = Post.new
    end

    def show
      @post = Post.find_by_id!(params[:id])
      @output = render_as_markdown(@post.content).html_safe
    end

    def edit
      @post = Post.find_by_id!(params[:id])
    end

    def update
      @post = Post.find_by_id!(params[:id])
      if @post.update_attributes(title: params[:title], content: params[:content])
        redirect_to admin_posts_path
      else
        render :edit
      end
    end

    def create
      @post = Post.new(title: params[:title], content: params[:content])
      if @post.save
        redirect_to admin_posts_path
      else
        render :new
      end
    end

    def destroy
      @post = Post.find_by_id!(params[:id])
      @post.destroy
      redirect_to admin_posts_path
    end

    private

    def render_as_markdown(content)
      renderer = HTML
      markdown = Redcarpet::Markdown.new(renderer, extensions = {
        fenced_code_blocks: true
      })
      markdown.render(content)
    end

    class HTML < Redcarpet::Render::HTML
      include Rouge::Plugins::Redcarpet
      def block_code(code, language)
        theme = Rouge::Themes::Github
        formatter = Rouge::Formatters::HTMLInline.new(theme)
        formatter = Rouge::Formatters::HTMLTable.new(formatter, opts={
          table_class: 'rouge-table',
          gutter_class: 'rouge-gutter',
          code_class: 'rouge-code'
        })
        lexer = Rouge::Lexers.const_get(language.capitalize.to_s).new
        formatter.format(lexer.lex(code))
      end
    end
  end
end