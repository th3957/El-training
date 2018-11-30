100.times do |n|
  title = Faker::Company.name
  contents = Faker::Lorem.paragraph(sentence_count = 10)
  status = [0, 1, 2].sample
  priority = [0, 1, 2].sample
  deadline = Faker::Time.between(DateTime.now + 1, DateTime.now + 50)
  Task.create!(title: title,
               contents: contents,
               status: status,
               priority: priority,
               deadline: deadline
               )
end
