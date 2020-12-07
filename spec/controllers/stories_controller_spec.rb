require 'rails_helper'
require_relative '../support/devise'

RSpec.describe StoriesController, type: :controller do
  before(:all) do
    @user = FactoryBot.create(:user)
    login_as @user
    @story = FactoryBot.create(:story)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to have_http_status(:redirect)
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to have_http_status(:redirect)
    end
  end

  describe 'GET #edit' do
    it 'returns http success' do
      get :edit, params: { id: @story }
      expect(response).to have_http_status(:redirect)
    end
  end
end
