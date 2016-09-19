class CommentPolicy < ApplicationPolicy
  def index?
    true
  end

  def destroy?
    user.present? && self.can_moderate?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end