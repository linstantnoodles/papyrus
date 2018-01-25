Given(/^an exercise with title "([^"]*)" exists$/) do |title|
  Exercise.create(title: title, description: 'test-content', test: 'test code')
end

Given(/^the exercise "([^"]*)" has description "([^"]*)"$/) do |title, description|
  exercise = Exercise.find_by_title(title)
  exercise.update(description: description)
end

Given(/^the exercise "([^"]*)" has test "([^"]*)"$/) do |title, test|
  exercise = Exercise.find_by_title(title)
  exercise.update(test: test)
end
