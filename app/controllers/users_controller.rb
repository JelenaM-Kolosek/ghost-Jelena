class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  include UsersHelper

  def show; end

  def edit; end

  def update
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

  def destroy
    authorize current_user
    DeleteTeamMemberJob.perform_later(@user)
    redirect_to user_team_path(current_user)
  end

  private

  def set_user
    @user = User.find(params[:id]).decorate
  end
end
