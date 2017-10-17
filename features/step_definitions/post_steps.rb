When(/^I create a new post$/) do
  visit new_post_path
  fill_in 'content_text', :with => "PAPYRUS CONTENT!"
  click_on 'Save'
end

Then(/^it should be visible$/) do
  expect(page).to have_content("PAPYRUS CONTENT!")
end