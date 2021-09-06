class Court < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader
  # validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :address, presence: true, length: { maximum: 100 }
  validates :price, presence: true, length: { maximum: 10 }
  validates :hour, presence: true, length: { maximum: 10 }
  validates :number, presence: true, length: { maximum: 10 }
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :remarks, length: { maximum: 200 }
end
