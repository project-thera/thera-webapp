class ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope.kind_of?(Array) ? scope.second : scope
    end

    def resolve
      scope
    end
  end
  
  attr_reader :user, :record

  def initialize(user, namespace_record)
    @user = user
    @record = namespace_record.kind_of?(Array) ? namespace_record.second : namespace_record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  def in_scope?
    scope.exists? id: record.id
  end

  def all_users
    user.sysadmin? || user.admin? 
  end
end
