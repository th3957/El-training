FactoryBot.define do
  factory :label do
    title { 'テストラベル１' }
  end

  factory :second_label, class: Label do
    title { 'テストラベル２' }
  end
end
