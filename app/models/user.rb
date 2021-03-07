class User < ApplicationRecord
  include Discard::Model
  #  has_paper_trail
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable  :registerable, :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :trackable

  has_and_belongs_to_many :groups

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  scope :list, -> { includes :groups }

  def to_s
    username
  end

  def cached_groups
    # Dont use "groups.pluck :name" because it does another query to the database
    @cached_groups ||= groups.collect &:name
  end

  def sysadmin?
    # Don´t use "groups.exists? name: 'System Administrator'"
    # because creates a new query and if the object is new doesn´t recognize
    # the groups added.
    cached_groups.include? Group::SYSADMIN
  end

  def admin?
    cached_groups.include? Group::ADMIN
  end

  def active_for_authentication?
    super && !discarded?
  end

  # def cas_extra_attributes=(extra_attributes)
  #   self.fullname = extra_attributes.try(:[], 'fullname')
  #   self.email = extra_attributes.try(:[], 'email')
  # end
#  def user_password
#    UserPassword.new user: self
#  end

#  def can_enable?
#    deleted?
#  end

#  def can_disable?
#    !deleted?
#  end
end
