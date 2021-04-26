class PatientVideoPolicy < ApplicationPolicy
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
    user.sysadmin? || user.admin? || user.supervisor?
  end

  def new?
    user.sysadmin? || user.admin? || user.patient?
  end

  def create?
    new?
  end

  def edit?
    false
  end

  def update?
    false
  end

  def video?
    user.sysadmin? || user.admin? || user.supervisor?
  end
  
  def destroy?
    user.sysadmin?
  end

end