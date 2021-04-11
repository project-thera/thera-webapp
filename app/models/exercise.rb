require_relative '../data/classification_labels'

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

  def self.blow_exercise_goals
    [true, false]
  end

  def self.speech_exercise_goals
    nil
  end

  def self.classification_exercise_goals
    ClassificationLabels.goals
  end

  def self.exercise_type_goals
    exercise_types.keys.map do | exercise_type |
      { exercise_type => send(:"#{exercise_type}_exercise_goals") }
    end
  end

  def as_routine_intent_data(state = 'completed')
    {
      id: id,
      name: name,
      state: state
    }
  end
end
