module UsersHelper
    def user_params
        params.require(:user).permit(:id,:full_name, :email, :role, :bio, :slug, :password, :image)
      end
end
