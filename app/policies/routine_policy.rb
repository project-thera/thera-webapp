class RoutinePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.sysadmin? || user.admin?
        scope
      elsif user.supervisor?
        scope.supervised_by(user)
      elsif user.patient?
        scope.owned_by(user)
      else
        scope.none
      end
    end
  end

  def index?
    user.sysadmin? || user.admin? || user.supervisor? || user.patient?
  end

  def new?
    user.sysadmin? || user.admin? || user.supervisor?
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
end