class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  include UsersHelper

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html do
          redirect_to @user, notice: 'User was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def team
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
