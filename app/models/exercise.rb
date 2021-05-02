require_relative '../data/classification_labels'

class Exercise < ApplicationRecord
  include Discard::Model
  
  has_many :routine_exercises
  has_many :routines, through: :routine_exercises, inverse_of: :exercises

  EXERCISE_TYPE_BLOW = 'blow'.freeze
  EXERCISE_TYPE_SPEECH = 'speech'.freeze
  EXERCISE_TYPE_CLASSIFICATION = 'classification'.freeze

  def self.exercise_types
    {
      EXERCISE_TYPE_BLOW => "Soplido",
      EXERCISE_TYPE_SPEECH => "Reconocimiento de voz",
      EXERCISE_TYPE_CLASSIFICATION => "Reconocimiento facial"
    }
  end

  def self.exercise_type_step_fields
    {
      EXERCISE_TYPE_BLOW => ['goal', 'time'],
      EXERCISE_TYPE_SPEECH => ['goal', 'image'],
      EXERCISE_TYPE_CLASSIFICATION => ['goal', 'time']
    }
  end

  def self.blow_exercise_goals
    BlowLabels.goals
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
