class Court < ApplicationRecord
  geocoded_by :address
  before_validation :geocode
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
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
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags
    old_tags.each do |old|
      self.court_tags.delete Tag.find_by(tag_name: old)
    end
    new_tags.each do |new|
      court_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << court_tag
    end
  end
end
