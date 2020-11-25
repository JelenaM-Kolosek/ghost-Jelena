class UsersPolicy < ApplicationPolicy
    def user_invite?
        current_user.admin?
    end
end