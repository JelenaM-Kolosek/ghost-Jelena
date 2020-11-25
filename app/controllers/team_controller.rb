class TeamController < ApplicationController

    before_action :authenticate_user!

    def index
       @users= User.all
    end

    def user_invite
 
        @user = User.new
    end
end
