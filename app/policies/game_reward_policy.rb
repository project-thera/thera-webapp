class GameRewardPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.sysadmin? || user.admin?
        scope
      elsif user.supervisor? || user.patient?
        scope.owned_by_user(user)
      else
        scope.none
      end
    end
  end

  def index?
    user.sysadmin? || user.admin? || user.supervisor?
  end

  def new?
    user.sysadmin? || user.admin?
  end

  def create?
    new?
  end

  def edit?
    create?
  end

  def update?
    edit?
  end
  
  def destroy?
    user.sysadmin?
  end

  def softable?
    user.sysadmin? || user.admin?
  end

  def undiscard?
    record.discarded? && softable?
  end

  def discard?
    record.undiscarded? && softable?
  end

  def start_supervision?
    user.sysadmin? || user.admin? || (user.supervisor? && record.supervisor_id.nil?)
  end

  def stop_supervision?
    user.sysadmin? || user.admin? || (user.supervisor? && (user.id == record.supervisor_id))
  end
end