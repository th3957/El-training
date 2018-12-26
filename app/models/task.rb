class Task < ApplicationRecord
  belongs_to :user
  has_many :labelings, dependent: :destroy
  has_many :labeling_labels, through: :labelings, source: :label

  enum sort: { sort_by_status: 0, sort_by_priority: 1, sort_by_deadline: 2 }
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
    def sort(query = nil)
      rel = order(status: :asc) if query == "0"
      rel = order(priority: :desc) if query == "1"
      rel = order(deadline: :asc) if query == "2"
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

    def label_search(query)
      rel = where(id: Labeling.where(label_id: 1).pluck(:task_id)) if query == "0"
      rel = where(id: Labeling.where(label_id: 2).pluck(:task_id)) if query == "1"
      rel = where(id: Labeling.where(label_id: 3).pluck(:task_id)) if query == "2"
      rel = where(id: Labeling.where(label_id: 4).pluck(:task_id)) if query == "3"
      rel
    end
  end
end
