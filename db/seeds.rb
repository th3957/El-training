1.times do |n|
  name = "管理ユーザー"
  email = "1@gmail.com"
  password = "111111"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    role: 1
    )
end

1.times do |n|
  name = "一般ユーザー"
  email = "2@gmail.com"
  password = "222222"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password
    )
end

30.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.unique.email
  password = Faker::Internet.password(6)
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password
    )
end

1000.times do |n|
  title = Faker::Company.name
  contents = Faker::Lorem.paragraph(sentence_count = 10)
  status = [0, 1, 2].sample
  priority = [0, 1, 2].sample
  deadline = Faker::Time.between(DateTime.now + 1, DateTime.now + 50)
  user_id = User.pluck(:id).sample
  Task.create!(
    title: title,
    contents: contents,
    status: status,
    priority: priority,
    deadline: deadline,
    user_id: user_id
    )
end

labels = %w(
  入金待ち
  書類送付済み
  決裁待ち
  アポイント済み
)

labels.each do |l|
  Label.create!(title: l)
end

1000.times do |n|
  label_id = Label.pluck(:id).sample
  task_id = Task.pluck(:id).sample
  Labeling.create!(
    label_id: label_id,
    task_id: task_id
  )
end
