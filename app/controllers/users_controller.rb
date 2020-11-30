class UsersController < ApplicationController
  include UsersHelper
  before_action :set_user, only: [:show, :edit, :update]
  
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    authorize current_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def new_avatar
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def team
    authorize current_user
    @pending_users = User.pending.decorate
    @accepted_users = Kaminari.paginate_array(User.accepted.decorate).page(params[:page]).per(20)
    render template: 'users/team/team'
  end

  def user_invite
    @user = User.new
    authorize current_user
    render 'users/team/user_invite'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
  
end
