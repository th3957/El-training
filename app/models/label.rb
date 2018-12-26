class Label < ApplicationRecord
  has_many :labelings, dependent: :destroy
  has_many :labeling_tasks, through: :labelings, source: :task

  enum label_search: { "入金待ち": 0, "書類送付済み": 1, "決裁待ち": 2, "アポイント済み": 3 }

  validates :title, presence: true, length: { in: 1..10 }
end
