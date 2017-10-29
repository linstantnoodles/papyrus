When(/^I visit the home page$/) do
  @first_post = Post.create(title: 'test-title', content: 'test-content')
  @second_post = Post.create(title: 'test-title-2', content: 'test-content-2')

  visit root_path
end

Then(/^I should see the posts$/) do
  expect(page).to have_content(@first_post.title)
  expect(page).to have_content(@second_post.title)
end

When(/^I visit a post page$/) do
  @post = Post.create(title: 'test-title', content: 'test-content')

  visit post_path(@post)
end

Then(/^I should see the post details$/) do
  expect(page).to have_content('Test-title')
  expect(page).to have_content(@post.content)
end