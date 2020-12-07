require 'rails_helper'
require_relative '../support/devise'

RSpec.describe UsersController, type: :controller do
  describe 'GET /' do
    user = FactoryBot.create(:user)
    login_user user

    context 'from admin login' do
      it 'should return 200:ok' do
        get user_url(user)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
