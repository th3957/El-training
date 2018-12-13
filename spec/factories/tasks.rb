FactoryBot.define do

  # テストユーザー１が作成
  factory :task do
    title { 'テストケース１のタイトル' }
    contents { 'テストケース１のコンテンツ' }
    deadline { Time.zone.local(2019,11,10,7,00) } # 2019年11月10日(日) 07時00分
    status { 'started' }
    priority { 'priority_high' }
    user
  end

  # テストユーザー２が作成
  factory :second_task, class: Task do
    title { 'テストケース２のタイトル' }
    contents { 'テストケース２のコンテンツ' }
    deadline { Time.zone.local(2050,11,11,9,00) }
    status { 'finished' }
    priority { 'priority_high' }
    association :user, factory: :second_user
  end

  # テストユーザー２が作成
  factory :third_task, class: Task do
    title { 'テストケース３のタイトル' }
    contents { 'テストケース３のコンテンツ' }
    deadline { Time.zone.local(2019,10,10,12,00) }
    status { 'before_start' }
    priority { 'priority_low' }
    association :user, factory: :second_user
  end

  # テストユーザー２が作成
  factory :fourth_task, class: Task do
    title { 'テストケース４のタイトル' }
    contents { 'テストケース４のコンテンツ' }
    deadline { Time.zone.local(2020,11,11,6,00) }
    status { 'started' }
    priority { 'priority_middle' }
    association :user, factory: :second_user
  end
end
