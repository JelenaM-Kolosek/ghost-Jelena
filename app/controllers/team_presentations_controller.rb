class TeamPresentationsController < ApplicationController
  include TeamPresentationsHelper
  before_action :set_user, only: %i[edit update]

  def index
    @team_presentations = TeamPresentation.all
  end

  def new; end

  def create
    @team_presentation = TeamPresentation.new(team_presentation_params)
    if @team_presentation.save
      redirect_to team_presentations_path
    else
      redirect_to new_team_presentation_path
    end
  end

  def edit; end

  def update
    if @team_presentation.update(team_presentation_params)
      redirect_to team_presentations_path
    else
      redirect_to edit_team_presentation_path
    end
  end

  private

  def set_team_presentation
    @team_presentation = TeamPresentation.find(params[:id])
  end
end
