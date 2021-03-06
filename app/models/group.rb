class Group < ApplicationRecord
  include Discard::Model

  SYSADMIN = 'System Administrator'.freeze
  ADMIN = 'Administrator'.freeze
  SUPERVISOR = 'Supervisor'.freeze
  PATIENT = 'Patient'.freeze

  has_and_belongs_to_many :users

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def to_s
    name
  end

  def self.patient
    Group.find_by! name: PATIENT
  end
end
