Given(/^I am a logged in admin$/) do
  user = User.create(name: 'admin', password: 'password')
  visit login_path
  fill_in 'name', :with => user.name
  fill_in 'password', :with => user.password
  click_on 'Login'
end

Given(/^an admin user with name "([^"]*)" and password "([^"]*)" exists$/) do |name, password|
  User.create(name: name, password: password)
end