Given(/^a post with title "([^"]*)" exists$/) do |title|
  Post.create(title: title, content: 'test-content')
end

Given(/^the post "([^"]*)" has content "([^"]*)"$/) do |title, content|
  post = Post.find_by_title(title)
  post.update(content: content)
end