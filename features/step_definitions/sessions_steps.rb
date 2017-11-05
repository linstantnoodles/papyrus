Given(/^I am a user$/) do
  @user = User.create(name: 'admin', password: 'password')
end

When(/^I submit the login form$/) do
  visit login_path
  fill_in 'name', :with => @user.name
  fill_in 'password', :with => @user.password
  click_on 'Login'
end

Then(/^I am logged in$/) do
  expect(page).to have_content('Logout')
end