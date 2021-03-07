class Group < ApplicationRecord
  include Discard::Model

  SYSADMIN = 'System Administrator'.freeze
  ADMIN = 'Administrator'.freeze

  has_and_belongs_to_many :users

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def to_s
    name
  end
end
