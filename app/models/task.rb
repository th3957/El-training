class Task < ApplicationRecord
  validates :title, presence: true, length: { in: 1..50 }
  validates :contents, presence: true,length: { in: 1..200 }
  validates :deadline, presence: true
  validate :deadline_cannot_be_in_the_past

  def deadline_cannot_be_in_the_past
    if deadline < Time.zone.now
      errors.add(I18n.t('view.deadline'), ": Deadline can not be set in the past.")
    end
  end
end
