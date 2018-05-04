When(/^I visit the home page$/) do
  visit root_path
end

When(/^I visit the admin home page$/) do
  visit admin_posts_path
end

When(/^I visit the login page$/) do
  visit login_path
end

Given(/^I visit the admin exercises page$/) do
  visit admin_exercises_path
end

Given(/^I visit the admin tags page$/) do
  visit admin_tags_path
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field_name, text|
  fill_in field_name, :with => text
end

When(/^I click "([^"]*)"$/) do |text|
  click_on text
end

When(/^I accept the alert dialog$/) do
  accept_alert
end

Then(/^I should see "([^"]*)"$/) do |text|
  expect(page).to have_content(text)
end

Then(/^I should see button "([^"]*)"$/) do |text|
  expect(page.has_button?(text)).to be(true)
end

Then(/^I should not see "([^"]*)"$/) do |text|
  expect(page).not_to have_content(text)
end

When(/^I select "([^"]*)" for "([^"]*)"$/) do |option, field_name|
  select option, :from => field_name
end

When(/^I click "([^"]*)" for row with text "([^"]*)"$/) do |target_text, row_text|
  find('tr', text: row_text).click_link(target_text)
end
