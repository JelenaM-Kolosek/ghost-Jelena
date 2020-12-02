module TeamPresentationsHelper
  def team_presentation_params
    params.require(:team_presentation).permit(:title, :description)
  end
end
