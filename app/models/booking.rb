class Booking < ApplicationRecord
  belongs_to :pool
  belongs_to :user


  after_commit -> do
    pool.bookings.each do |booking|
      user = booking.user
      broadcast_replace_to(
        "user_#{user.id}",
        partial: "pools/bookings",
        target: "pool_#{pool.id}_bookings",
        locals: { pool: pool, user: user }
      )
    end
  end
end
