class StoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin? || user.editor?
        scope.all
      else
        scope.stories_author(user)
      end
    end
  end
end
