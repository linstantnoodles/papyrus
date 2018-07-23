#!/usr/bin/env ruby
require 'yaml'
require 'net/http'
require 'json'

subcommand = ARGV[0]
subcommands = ['til']
if !subcommands.include?(subcommand)
    print "Acceptable commands #{subcommands}\n"
    exit
end
if subcommand == 'til'
  ftemplate = File.new('/Users/alin/src/papyrus/script/til_template.md', 'r')
  system('cat /Users/alin/src/papyrus/script/til_template.md | vim - +"w til.md"')
  til_file = File.new('til.md', 'r')
  content = til_file.read
  meta = YAML.load(content)
  content_in_lines = IO.readlines("til.md")

  title = meta['title']
  body = content_in_lines[3..content_in_lines.length - 1].join('')

  print "Creating post with title #{title}...\n"
  print "\n"
  data = {
    title: title,
    content: content,
    tags: 'til',
    stage: 'published'
  }
  api_endpoint = "http://www.linisnil.com/api/posts"
  uri = URI.parse(api_endpoint)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.request_uri)
  request['Content-Type'] = 'applicaton/json'
  request.body = data.to_json
  response = http.request(request)
  if response.code != '201'
    p response.body
  end
end