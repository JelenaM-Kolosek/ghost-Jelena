require 'rails_helper'
require_relative '../support/devise'

RSpec.feature 'new invite', type: :feature do
  before(:all) do
    @user = FactoryBot.create(:user)
    login_as @user
  end
  context 'send invite to user' do
    scenario 'successfully' do
      visit new_invite_path
      fill_in 'user[email]', with: Faker::Internet.unique.email
      select('author', from: 'user[role]').select_option
      click_button 'Send an invitation'
      expect(page).to have_content 'Invitation has been sent successfully'
    end
    scenario 'missing email, failed' do
      visit new_invite_path
      select('author', from: 'user[role]').select_option
      click_button 'Send an invitation'
      expect(page).to have_content 'Email can\'t be blank'
    end
  end
end
