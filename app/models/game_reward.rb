class GameReward < ApplicationRecord
  has_one :user

  MAX_CURRENT_ROBOT = 8

  scope :owned_by_user, -> (user) {
    joins(:user).where(user: user)
  }
end
