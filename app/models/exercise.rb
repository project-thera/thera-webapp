class Exercise < ApplicationRecord
  include Discard::Model
  
  has_many :routine_exercises
  has_many :routines, through: :routine_exercises, inverse_of: :exercises

  def self.exercise_types
    {
      blow: "Soplido",
      speech: "Reconocimiento de voz",
      classification: "Reconocimiento facial"
    }
  end
end
