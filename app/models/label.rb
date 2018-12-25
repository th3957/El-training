class Label < ApplicationRecord
  has_many :labelings, dependent: :destroy
  has_many :labeling_tasks, through: :labelings, source: :task

  validates :title, presence: true, length: { in: 1..10 }
end
