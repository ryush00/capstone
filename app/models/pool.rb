class Pool < ApplicationRecord
  belongs_to :user
  belongs_to :start_place, class_name: "Place", foreign_key: "start_place_id"
  belongs_to :end_place, class_name: "Place", foreign_key: "end_place_id"
  has_many :bookings, dependent: :destroy

  # enum
  enum pool_type: { car: 0, taxi: 1 }

  # Pool이 커밋된 후 자동으로 Booking 생성
  after_commit :create_initial_booking, on: :create

  # validations
  validates :pool_type, presence: true

  validates :start_place_id, presence: true
  validates :end_place_id, presence: true

  # 시간
  validates :start_at, presence: true
  validates :end_at, presence: true

  # user_min은 user_max보다 작거나 같아야 한다.
  validates :user_min, presence: true
  validates :user_max, presence: true
  validate :user_min_less_than_user_max

  def owner
    bookings.first&.user
  end
  private

  def create_initial_booking
    # Booking이 이미 존재하지 않을 경우에만 생성
    bookings.create(user_id: user_id, pool_id: id) unless bookings.exists?(user_id: user_id)
  end

  def user_min_less_than_user_max
    return if user_min.blank? || user_max.blank?

    if user_min > user_max
      errors.add(:user_min, "사람 수가 올바르지 않습니다.")
    end
  end
end
