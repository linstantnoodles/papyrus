Given(/^I am a logged in admin$/) do
  @user = User.create(name: 'admin', password: 'password')
  visit login_path
  fill_in 'name', :with => @user.name
  fill_in 'password', :with => @user.password
  click_on 'Login'
end

When(/^I visit the posts page$/) do
  @first_post = Post.create(title: 'test-title', content: 'test-content')
  @second_post = Post.create(title: 'test-title-2', content: 'test-content-2')

  visit admin_posts_path
end

Then(/^I should see all of my posts$/) do
  expect(page).to have_content(@first_post.title)
  expect(page).to have_content(@second_post.title)
end

When(/^I edit an existing post$/) do
  @post = Post.create(title: 'test-title', content: 'test-content')

  visit edit_admin_post_path(@post)

  fill_in 'title', :with => 'updated title'
  fill_in 'content', :with => 'updated content'
  click_button 'Save'
end

Then(/^I should see the edited post$/) do
  expect(page).to have_content('updated title')
end

When(/^I create a new post$/) do
  visit new_admin_post_path
  fill_in 'title', :with => "test title"
  fill_in 'content', :with => "test content"

  click_on 'Save'
end

Then(/^it should be visible$/) do
  expect(page).to have_content("test title")
end

When(/^I delete a post$/) do
  @post = Post.create(title: 'test-title', content: 'test-content')

  visit edit_admin_post_path(@post)
  click_on 'Delete'

  visit admin_posts_path
end

Then(/^I should not see the post$/) do
  expect(page).not_to have_content(@post.title)
end