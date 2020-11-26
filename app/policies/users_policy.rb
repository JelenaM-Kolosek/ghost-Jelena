class UsersPolicy < ApplicationPolicy
      def update?
        user.present? || user.admin?
      end

      def show?
        user.present? ||  user.admin?
      end
    
end