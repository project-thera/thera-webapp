class RoutineIntent < ApplicationRecord
  belongs_to :routine, required: true

  has_many :routine_intent_exercises

  validates :started_at, presence: true

  scope :supervised_by, -> (user) {
    joins(:routine).where(routines: { supervisor: user })
  }

  scope :owned_by, -> (user) {
    joins(:routine).where(routines: { patient: user })
  }
end
