FactoryBot.define do
  factory :task do
    title { 'テストケース１のタイトル' }
    contents { 'テストケース１のコンテンツ' }
    deadline { Time.zone.local(2019,11,11,7,00) }
  end

  factory :second_task, class: Task do
    title { 'テストケース２のタイトル' }
    contents { 'テストケース２のコンテンツ' }
    deadline { Time.zone.local(2050,11,11,9,00) }
  end

  factory :third_task, class: Task do
    title { 'テストケース３のタイトル' }
    contents { 'テストケース３のコンテンツ' }
    deadline { Time.zone.local(2019,10,10,12,00) }
  end
end
