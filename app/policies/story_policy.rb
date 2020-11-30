class StoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin? || user.editor?
        scope.stories_desc
      else
        scope.stories_desc_author(user)
      end
    end
  end
end
