Given(/^a post with title "([^"]*)" exists$/) do |title|
  Post.create(title: title, content: 'test-content')
end

Given(/^the post "([^"]*)" is a draft$/) do |title|
  post = Post.find_by_title(title)
  post.update(stage: Post::Stages::DRAFT)
end

Given(/^the post "([^"]*)" is published$/) do |title|
  post = Post.find_by_title(title)
  post.publish
  post.save
end

Given(/^the post "([^"]*)" has content "([^"]*)"$/) do |title, content|
  post = Post.find_by_title(title)
  post.update(content: content)
end

Given(/^the post "([^"]*)" has (\d+) child posts$/) do |parent_title, number_of_child_posts|
  parent_post = Post.find_by_title(parent_title)
  number_of_child_posts.to_i.times do |i|
    Post.create(
      title: "#{parent_title}_child_#{i}",
      content: 'child',
      post: parent_post
    )
  end
end

Given(/^the post "([^"]*)" is a child of post "([^"]*)"$/) do |child_title, parent_title|
  parent_post = Post.find_by_title(parent_title)
  child_post = Post.find_by_title(child_title)
  child_post.update(parent_post: parent_post)
end