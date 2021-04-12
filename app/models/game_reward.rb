class GameReward < ApplicationRecord
  has_one :user

  scope :owned_by_user, -> (user) {
    joins(:user).where(user: user)
  }
end
