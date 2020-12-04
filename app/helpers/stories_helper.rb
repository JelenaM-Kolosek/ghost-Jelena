module StoriesHelper
  def story_params
    params.require(:story).permit(
      :title,
      :content,
      :tag_list,
      :search
    )
  end
end
