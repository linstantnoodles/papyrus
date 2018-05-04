Given(/^a tag with name "([^"]*)" exists$/) do |name|
  Tag.create(name: name)
end