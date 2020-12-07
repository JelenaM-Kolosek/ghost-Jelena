require 'rails_helper'

RSpec.feature 'Authentication', type: :feature do
  context 'registration' do
    scenario 'user should sign up successfully' do
      visit new_user_registration_path
      fill_in 'Full name', with: Faker::Internet.name
      fill_in 'Email', with: Faker::Internet.unique.email
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_button 'Sign up'
      expect(page).to have_content 'Welcome! You have signed up successfully.'
    end

    scenario 'password to short, sign up failed' do
      visit new_user_registration_path
      fill_in 'Full name', with: Faker::Internet.name
      fill_in 'Email', with: Faker::Internet.unique.email
      fill_in 'Password', with: '123'
      fill_in 'Password confirmation', with: '123'
      click_button 'Sign up'
      expect(page).to have_content 'Password is too short (minimum is 6 characters)'
    end

    scenario 'password and confirmation password are not the same, sign up failed' do
      visit new_user_registration_path
      fill_in 'Full name', with: Faker::Internet.name
      fill_in 'Email', with: Faker::Internet.unique.email
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123987'
      click_button 'Sign up'
      expect(page).to have_content 'Password confirmation doesn\'t match Password'
    end

    scenario 'email has already been taken, sign up failed' do
      user = FactoryBot.create(:user)
      visit new_user_registration_path
      fill_in 'Full name', with: Faker::Internet.name
      fill_in 'Email', with: user.email
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_button 'Sign up'
      expect(page).to have_content 'Email has already been taken'
    end
  end

  context 'login' do
    before(:all) do
      @user = FactoryBot.create(:user)
    end

    scenario 'user should logged in successfully' do
      visit user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully.'
    end

    scenario 'wrong password, logged in failed' do
      visit user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'password'
      click_button 'Log in'
      expect(page).to have_content 'Invalid Email or password.'
    end
    scenario 'wrong email, logged in failed' do
      visit user_session_path
      fill_in 'Email', with: Faker::Internet.unique.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
      expect(page).to have_content 'Invalid Email or password.'
    end
  end

  context 'sign out' do
    scenario 'user should sign out successfully' do
      visit user_session_path
      expect(page).to have_content 'Sign up'
    end
  end
end
