require 'rouge'
require 'rouge/plugins/redcarpet'

class PostDecorator
  attr_reader :post

  delegate :id, :series?, :published?, :child_posts, :updated_at, to: :post

  def initialize(post:)
    @post = post
  end

  def title
    if @post.series?
      "#{@post.title.capitalize} (series)"
    elsif @post.tagged_with?('til')
      "#{@post.title.capitalize} (til)"
    else
      @post.title.capitalize
    end
  end

  def content
    render_as_markdown(@post.content)
  end

  def render_as_markdown(content)
    renderer = MyHTML.new(link_attributes: { target: '_blank' }, prettify: true)
    markdown = Redcarpet::Markdown.new(renderer, extensions = {
      fenced_code_blocks: true
    })
    markdown.render(content).html_safe
  end

  class MyHTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet

    def block_code(code, language)
      theme = Rouge::Themes::Github
      formatter = Rouge::Formatters::HTMLInline.new(theme)
      formatter = Rouge::Formatters::HTMLTable.new(formatter, opts={
        table_class: 'rouge-table',
        gutter_class: 'rouge-gutter',
        code_class: 'rouge-code'
      })
      lexer = (language) ? Rouge::Lexer.find(language) : Rouge::Lexer.guess_by_source(code)
      tokens = lexer.lex(code)
      formatted_code_block = formatter.format(tokens)
      %(<div class="code-container">#{formatted_code_block}</div>)
    end
  end
end