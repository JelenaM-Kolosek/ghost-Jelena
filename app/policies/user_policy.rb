class UserPolicy < ApplicationPolicy
  attr_reader :user, :post

  def initialize(user, _post)
    @user = user
  end

  def update?
    user.admin?
  end

  def show?
    user.present?
  end

  def user_invite?
    user.admin?
  end

end
