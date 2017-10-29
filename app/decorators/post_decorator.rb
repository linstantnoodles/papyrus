require 'rouge'
require 'rouge/plugins/redcarpet'

class PostDecorator
  attr_reader :post

  delegate :updated_at, to: :post

  def initialize(post:)
    @post = post
  end

  def title
    @post.title.capitalize
  end

  def content
    render_as_markdown(@post.content).html_safe
  end

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