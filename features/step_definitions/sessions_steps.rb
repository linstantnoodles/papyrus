Given(/^I am a user$/) do
  @user = User.new(name: 'admin', password: 'password', password_confirmation: 'password')
end

When(/^I submit the login form$/) do
  visit login_path
  fill_in 'username', :with => @user.name
  fill_in 'password', :with => @user.password
end

Then(/^I am logged in$/) do
  expect(page).to have_content('Logout')
end