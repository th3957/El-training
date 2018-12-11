1.times do |n|
  name = "テスター"
  email = "1@gmail.com"
  password = "111111"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               )
end

30.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.unique.email
  password = Faker::Internet.password(6)
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               )
end

1000.times do |n|
  title = Faker::Company.name
  contents = Faker::Lorem.paragraph(sentence_count = 10)
  status = [0, 1, 2].sample
  priority = [0, 1, 2].sample
  deadline = Faker::Time.between(DateTime.now + 1, DateTime.now + 50)
  user_id = User.pluck(:id).sample
  Task.create!(title: title,
               contents: contents,
               status: status,
               priority: priority,
               deadline: deadline,
               user_id: user_id
               )
end
