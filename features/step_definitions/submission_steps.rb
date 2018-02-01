Given(/^a submission with content "([^"]*)" exists for exercise "([^"]*)"$/) do |submission_content, exercise_title|
  exercise = Exercise.find_by_title(exercise_title)
  Submission.create(content: submission_content, exercise: exercise)
end