class Task < ApplicationRecord
  belongs_to :user

  enum sort: {
    sort_by_create_at: 0,
    sort_by_status: 1,
    sort_by_priority: 2,
    sort_by_deadline: 3
  }
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

  class << self
    def sort(query)
      rel = order(created_at: :desc) if query == "0"
      rel = order(status: :asc) if query == "1"
      rel = order(priority: :desc) if query == "2"
      rel = order(deadline: :asc) if query == "3"
      rel
    end

    def search(t, s, p)
      if s.present? && p.present?
        rel = where("title LIKE ?", "%#{t}%").where(status: s).where(priority: p)
      elsif s.present?
        rel = where("title LIKE ?", "%#{t}%").where(status: s)
      elsif p.present?
        rel = where("title LIKE ?", "%#{t}%").where(priority: p)
      else
        rel = where("title LIKE ?", "%#{t}%")
      end
      rel
    end
  end
end
