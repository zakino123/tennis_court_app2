class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :court

  validates_uniqueness_of :court_id, scope: :user_id
end
