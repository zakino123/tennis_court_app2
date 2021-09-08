class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :court
  validates :user_id, presence: true
  validates :court_id, presence: true
  validates :context, presence: true, length: { maximum: 300 }
end
