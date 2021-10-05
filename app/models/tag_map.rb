class TagMap < ApplicationRecord
  belongs_to :court
  belongs_to :tag

  validates :court_id, presence: true
  validates :tag_id, presence: true
end
