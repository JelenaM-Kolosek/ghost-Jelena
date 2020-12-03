module Api
  module V1
    class StoriesController < ApplicationController
      before_action :restrict_access
      respond_to :json

      include StoriesHelper
      before_action :set_story, only: %i[show edit update destroy]

      def index
        @stories = policy_scope(Story)
        @stories = @stories.search(params[:search]) if params[:search]
        respond_with @stories
      end

      def show
        respond_with @user
      end

      def create
        respond_with Story.create(story_params)
      end

      def update
        respond_with Story.update(story_params)
      end

      def destroy
        respond_with Story.destroy(@story)
      end

      private

      def set_story
        @story = Story.find(params[:id]).decorate
      end

      def restrict_access
        authenticate_or_request_with_http_token do |token, _options|
          ApiKey.exists?(access_token: token)
        end
      end
    end
  end
end
