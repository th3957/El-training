class Task < ApplicationRecord
  enum status: { before_start: 0, started: 1, finished: 2 }
  enum priority: { priority_low: 0, priority_middle: 1, priority_high: 2 }

  validates :title, presence: true, length: { in: 1..50 }
  validates :contents, presence: true, length: { in: 1..200 }
  validates :status, presence: true, inclusion: { in: Task.statuses.keys }
  validates :priority, presence: true, inclusion: { in: Task.priorities.keys }
  validates :deadline, presence: true
  validate :deadline_cannot_be_in_the_past

  def deadline_cannot_be_in_the_past
    if deadline < Time.zone.now
      errors.add(I18n.t('view.deadline'), ": Deadline can not be set in the past.")
    end
  end
end
