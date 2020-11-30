module StoriesHelper
  def story_params
    params.require(:story).permit(
      :title,
      :content
    )
  end
end
