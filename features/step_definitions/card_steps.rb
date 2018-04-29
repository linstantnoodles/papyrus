Given(/^a card with front "([^"]*)" exists$/) do |front|
  Card.create(front: front, back: 'test-back')
end

Given(/^a card with front "([^"]*)" and back "([^"]*)" exists$/) do |front, back|
  Card.create(front: front, back: back)
end

Given(/^the card with front "([^"]*)" is due for review$/) do |front|
  card = Card.find_by_front(front)
  card.update(next_due_date: 1.day.ago)
end

Given(/^the card with front "([^"]*)" is due for review today$/) do |front|
  card = Card.find_by_front(front)
  card.update(next_due_date: Time.now)
end

Given(/^the card with front "([^"]*)" is due for review tomorrow$/) do |front|
  card = Card.find_by_front(front)
  card.update(next_due_date: Time.now.tomorrow)
end

Given(/^the card with front "([^"]*)" is not due for review$/) do |front|
  card = Card.find_by_front(front)
  card.update(next_due_date: 1.day.from_now)
end

Given(/^the card with front "([^"]*)" has tags "([^"]*)"$/) do |front, tags|
  tags = tags.split(',').map { |name| Tag.find_or_create_by(name: name.strip) }
  card = Card.find_by_front(front)
  card.update(tags: tags)
end
