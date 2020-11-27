class UserPolicy < ApplicationPolicy
  def update?
    user.admin?
  end

  def show?
    user.present?
  end
end
