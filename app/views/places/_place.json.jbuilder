json.extract! place, :id, :place_type, :name, :latitude, :longitude, :created_at, :updated_at
json.url place_url(place, format: :json)
