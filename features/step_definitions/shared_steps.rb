When(/^I visit the home page$/) do
  visit root_path
end

When(/^I visit the admin home page$/) do
  visit admin_posts_path
end

When(/^I visit the login page$/) do
  visit login_path
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field_name, text|
  fill_in field_name, :with => text
end

When(/^I click "([^"]*)"$/) do |text|
  click_on text
end

Then(/^I should see "([^"]*)"$/) do |text|
  expect(page).to have_content(text)
end

Then(/^I should not see "([^"]*)"$/) do |text|
  expect(page).not_to have_content(text)
end

