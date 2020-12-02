class TeamPresentationPolicy < ApplicationPolicy
  def index?
    user.admin?
  end
end
