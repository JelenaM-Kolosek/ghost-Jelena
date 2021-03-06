class StoryPolicy < ApplicationPolicy
  attr_reader :user, :story

  def initialize(user, story)
    @user = user
    @story = story
  end

  class Scope < Scope
    def resolve
      if user.admin? || user.editor?
        scope.all
      else
        scope.stories_author(user)
      end
    end
  end

  def new?
    @user.present?
  end

  def create?
    @user.present?
  end

  def edit?
    @user.admin? || @user.editor? || users_story
  end

  def update?
    @user.admin? || @user.editor? || users_story
  end

  def destroy?
    @user.admin? || @user == @story.user
  end

  private

  def users_story
    (@user.author? && @user == @story.user)
  end
end
