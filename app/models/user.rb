class User < ApplicationRecord
  include Discard::Model
  #  has_paper_trail
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable  :registerable, :recoverable, :rememberable, :validatable
  devise :database_authenticatable,
    :trackable,
    :confirmable,
    :registerable,
    :recoverable
    
    # ,:jwt_authenticatable,
    # jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  # https://stackoverflow.com/questions/56617857/how-do-i-create-a-self-referential-association-table-rails-migration
  # FIXME Add supervisors and patients scopes
  belongs_to :supervisor, class_name: 'User', inverse_of: :patients, required: false
  belongs_to :game_reward, required: true

  before_validation :build_game_reward, on: :create

  has_many :patients,
    foreign_key: :supervisor_id,
    inverse_of: :supervisor,
    class_name: 'User'

  # , foreign_key: :supervisor_id
  has_many :supervised_routines,
    class_name: 'Routine',
    inverse_of: :supervisor,
    foreign_key: :supervisor_id

  has_many :routines,
    inverse_of: :patient,
    foreign_key: :patient_id

  has_many :routine_intents, through: :routines

  has_many :patient_videos,
    inverse_of: :patient,
    foreign_key: :patient_id

  has_and_belongs_to_many :groups

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :fullname, presence: true
  validates :email, presence: true, email: true, uniqueness: { case_sensitive: false }

  scope :list, -> { includes :groups }
  scope :patients, -> { list.where(groups: { name: Group::PATIENT }) }
  scope :patients_with_supervisor, -> { patients.where.not(supervisor_id: nil) }

  scope :owned_or_without_supervision_patients, -> (user) {
      joins(:groups)
        .where(
          "
            ((#{table_name}.supervisor_id = ? OR #{table_name}.supervisor_id IS NULL) AND groups.name = ?)
            OR #{table_name}.id = ?
          ",
          user.id,
          Group::PATIENT,
          user.id,
        )
      # .where(groups: { name: [Group::PATIENT, Group::SUPERVISOR] })
  }

  scope :own_user, -> (user) { 
    where(id: user.id)
  }

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

  def supervisor?
    cached_groups.include? Group::SUPERVISOR
  end

  def patient?
    cached_groups.include? Group::PATIENT
  end

  def active_for_authentication?
    super && !discarded?
  end

  def add_patient_group
    self.groups << Group.patient
  end

  def start_supervision(context)
    self.supervisor = context[:user]

    save
  end

  def stop_supervision
    self.supervisor_id = nil

    save
  end

  #  def can_enable?
  #    deleted?
  #  end

  #  def can_disable?
  #    !deleted?
  #  end
end
