#!/usr/bin/env ruby
require 'yaml'
require 'net/http'
require 'json'
TIL_DIR = '/Users/alin/src/papyrus/.til/'
subcommand = ARGV[0]
subcommands = ['til']
if !subcommands.include?(subcommand)
    print "Acceptable commands #{subcommands}\n"
    exit
end
if subcommand == 'til'
  new_til_file_path = "#{TIL_DIR}til-#{Time.now.strftime('%F')}.md"
  ftemplate = File.new('/Users/alin/src/papyrus/script/til_template.md', 'r')
  system("cat /Users/alin/src/papyrus/script/til_template.md | vim - +'w #{new_til_file_path}'")
  til_file = File.new(new_til_file_path, 'r')
  content = til_file.read
  meta = YAML.load(content)
  content_in_lines = IO.readlines(new_til_file_path)
  title = meta['title']
  body = content_in_lines[3..content_in_lines.length - 1].join('')
  print "Publishing TIL #{title}...\n"
  print "\n"
  data = {
    title: title,
    content: body,
    tags: 'til',
    stage: 'published'
  }
  api_endpoint = "http://www.linisnil.com/api/posts"
  uri = URI.parse(api_endpoint)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.request_uri)
  request['Content-Type'] = 'application/json'
  request.body = data.to_json
  response = http.request(request)
  if response.code != '201'
    p response.body
  else
    print "Done!\n"
  end
end