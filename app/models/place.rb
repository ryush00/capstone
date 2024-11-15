class Place < ApplicationRecord
  enum place_type: [ :start, :end ]

  validates :place_type, presence: true
  validates :name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
