class StoriesController < ApplicationController
  include StoriesHelper
  before_action :set_story, only: %i[show edit update destroy]

  def show; end

  def index
    @stories = policy_scope(Story)
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(story_params)
    @story.user = current_user
    if @story.save
      redirect_to story_path(@story)
    else
      redirect_to new_story_path
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @story.update(story_params)
        format.html do
          redirect_to @story, notice: 'Story was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @story }
      else
        format.html { render :edit }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @story.destroy
      redirect_to stories_path, notice: 'Story was successfully deleted.'
    else
      redirect_to @story
    end
  end

  private

  def set_story
    @story = Story.find(params[:id]).decorate
  end
end
