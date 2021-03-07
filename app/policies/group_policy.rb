class GroupPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.sysadmin? || user.admin?
        scope
      else
        scope.kept
      end
    end
  end

  def index?
    user.sysadmin? || user.admin?
  end

  def new?
    user.sysadmin?
  end

  def create?
    new?
  end

  def edit?
    user.sysadmin?
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