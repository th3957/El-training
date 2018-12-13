class Task < ApplicationRecord
  belongs_to :user

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

  scope :with_no_progress, -> { order(status: :asc) }
  scope :with_highest_priority, -> { order(priority: :desc) }
  scope :closest_to_deadline, -> { order(deadline: :asc) }
  scope :of_newest, -> { order(created_at: :desc) }
  scope :search_by_title, -> (t) {
    where("title LIKE ?", "%#{t}%")
  }
  scope :search_by_title_and_status, -> (t, s) {
    where("title LIKE ?", "%#{t}%").where(status: s)
  }
  scope :search_by_title_and_priority, -> (t, p) {
    where("title LIKE ?", "%#{t}%").where(priority: p)
  }
  scope :search_by_title_and_status_and_priority, -> (t, s, p) {
    where("title LIKE ?", "%#{t}%").where(status: s).where(priority: p)
  }
end
