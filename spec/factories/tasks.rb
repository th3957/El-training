FactoryBot.define do
  factory :task do
    title { 'テストケース１のタイトル' }
    contents { 'テストケース１のコンテンツ' }
    deadline { DateTime.now }
  end

  factory :second_task, class: Task do
    title { 'テストケース２のタイトル' }
    contents { 'テストケース２のコンテンツ' }
    deadline { DateTime.new(2050,11,11) }
  end

  factory :third_task, class: Task do
    title { 'テストケース３のタイトル' }
    contents { 'テストケース３のコンテンツ' }
    deadline { DateTime.now }
  end
end
