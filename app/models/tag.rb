class Tag < ApplicationRecord
  has_many :tag_maps, dependent: :destroy
  has_many :courts, through: :tag_maps
end
