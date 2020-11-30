class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]
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

  def set_user
    @user = User.find(params[:id]).decorate
  end
end
