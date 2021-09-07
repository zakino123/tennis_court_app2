class Court < ApplicationRecord
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
  after_validation :geocode
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

  class << self
    def within_box(distance, latitude, longitude)
      distance = distance
      center_point = [latitude, longitude]
      box = Geocoder::Calculations.bounding_box(center_point, distance)
      self.within_bounding_box(box)
    end

    def geocode
      uri = URI.escape("https://maps.googleapis.com/maps/api/geocode/json?address="+self.address.gsub(" ", "")+"&key=[ここにAPIキー]")
      res = HTTP.get(uri).to_s
      response = JSON.parse(res)
      self.latitude = response["results"][0]["geometry"]["location"]["lat"]
      self.longitude = response["results"][0]["geometry"]["location"]["lng"]
    end
  end
end