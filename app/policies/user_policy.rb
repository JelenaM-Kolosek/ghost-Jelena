class UserPolicy < ApplicationPolicy
  def edit?
    user.admin?
  end

  def show?
    user.present?
  end

  def user_invite?
    user.admin?
  end

  def team?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
