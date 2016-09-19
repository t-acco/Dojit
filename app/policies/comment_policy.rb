class CommentPolicy < ApplicationPolicy
  def index?
    true
  end

  def destroy?
    user.present? && (record.user == user || user.admin? || user.moderator?)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end