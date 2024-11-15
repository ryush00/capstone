class Place < ApplicationRecord
  enum place_type: [ :start, :end ]
end
