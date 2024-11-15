class Pool < ApplicationRecord
  belongs_to :user

  # enum
  enum pool_type: { car: 0, taxi: 1 }

  # validations
  validates :pool_type, presence: true
  # 시간
  validates :start_at, presence: true
  validates :end_at, presence: true

  # user_min은 user_max보다 작거나 같아야 한다.
  validates :user_min, presence: true
  validates :user_max, presence: true
  validate :user_min_less_than_user_max

  private
  def user_min_less_than_user_max
    if user_min > user_max
      errors.add(:user_min, "시간이 올바르지 않습니다.")
    end
  end
end
