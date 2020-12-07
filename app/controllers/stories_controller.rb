class StoriesController < ApplicationController
  include StoriesHelper
  before_action :set_story, only: %i[show edit update destroy]
  before_action :authorize_actions, only: %i[edit update destroy]

  def show
    redirect_to @story, status: :moved_permanently if request.path != story_path(@story)
  end

  def index
    @stories = policy_scope(Story)
    @stories = @stories.search(params[:search]) if params[:search]
    @stories = Kaminari.paginate_array(@stories).page(params[:page]).per(20)
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(story_params)
    @story.user = current_user
    if @story.save
      redirect_to story_path(@story), notice: 'Story was successfully created.'
    else
      redirect_to new_story_path,notice: 'Error! Try again!'
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

  def site_overview
    @stories_overview = params[:search] ? Story.all.search(params[:search]) : Story.all
    @stories_overview = Kaminari.paginate_array(@stories_overview).page(params[:page]).per(20)
  end

  private

  def set_story
    @story = Story.friendly.find(params[:id]).decorate
  end

  def authorize_actions
    authorize @story
  end
end
