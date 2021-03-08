class Exercise < ApplicationRecord
  include Discard::Model
  
  has_many :routine_exercises
  has_many :routines, through: :routine_exercises, inverse_of: :exercises
end
