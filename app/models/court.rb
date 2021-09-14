class Court < ApplicationRecord
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
  geocoded_by :address
  before_validation :geocode
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  mount_uploader :image, ImageUploader
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :address, presence: true, length: { maximum: 100 }, uniqueness: true
  validates :price, presence: true, length: { maximum: 10 }
  validates :number, presence: true, length: { maximum: 10 }
  validates :latitude, presence: true, uniqueness: true
  validates :longitude, presence: true, uniqueness: true
  validates :reserve, presence: true
  validates :remarks, length: { maximum: 200 }

  class << self
    def within_box(distance, latitude, longitude)
      distance = distance
      center_point = [latitude, longitude]
      box = Geocoder::Calculations.bounding_box(center_point, distance)
      self.within_bounding_box(box)
    end
  end
end
