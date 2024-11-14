class Place < ApplicationRecord
  enum place_type: [ :start, :end ]

  # 출발지로 지정된 Place 레코드를 가져오는 경우
  Place.start

  # 목적지로 지정된 Place 레코드를 가져오는 경우
  Place.end

end
