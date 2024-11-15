class Pool < ApplicationRecord
  belongs_to :user

  # enum
  enum pool_type: { car: 0, taxi: 1 }

end
