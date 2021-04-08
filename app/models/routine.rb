class Routine < ApplicationRecord
  include Discard::Model
  
  belongs_to :supervisor, class_name: 'User', inverse_of: :supervised_routines, required: false
  belongs_to :patient, class_name: 'User', inverse_of: :routines, required: false

  has_many :routine_exercises
  has_many :exercises, through: :routine_exercises, inverse_of: :routines

  accepts_nested_attributes_for :routine_exercises, allow_destroy: true, reject_if: :all_blank
end
