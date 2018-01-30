Given(/^a post with title "([^"]*)" exists$/) do |title|
  Post.create(title: title, content: 'test-content')
end

Given(/^the post "([^"]*)" is a draft$/) do |title|
  post = Post.find_by_title(title)
  post.update(stage: Post::Stages::DRAFT)
end

Given(/^the post "([^"]*)" is published$/) do |title|
  post = Post.find_by_title(title)
  post.update(stage: Post::Stages::PUBLISHED)
end

Given(/^the post "([^"]*)" has content "([^"]*)"$/) do |title, content|
  post = Post.find_by_title(title)
  post.update(content: content)
end
