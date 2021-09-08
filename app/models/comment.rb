class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :court
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :court_id, presence: true
  validates :context, presence: true, length: { maximum: 300 }
end
