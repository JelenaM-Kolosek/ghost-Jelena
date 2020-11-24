class UsersPolicy < ApplicationPolicy
      def update?
        user.present?
      end

      def show?
        user.present?
      end
    
end