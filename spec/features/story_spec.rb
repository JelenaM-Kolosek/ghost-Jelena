require 'rails_helper'
require_relative '../support/devise'

RSpec.feature 'Story', type: :feature do
  before(:all) do
    @user = FactoryBot.create(:user)
    login_as @user
  end

  context 'create story' do
    scenario 'successfully' do
      visit stories_path
      fill_in 'story[title]', with: Faker::Name.name
      fill_in 'story[tag_list]', with: 'tag1, tag2'
      fill_in 'story[content]', with: '123456'
      click_button 'Sumbit'
      expect(page).to have_content 'Story was successfully created.'
    end

    scenario 'successfully created without tag list' do
      visit stories_path
      fill_in 'story[title]', with: Faker::Name.name
      fill_in 'story[content]', with: '123456'
      click_button 'Sumbit'
      expect(page).to have_content 'Story was successfully created.'
    end

    scenario 'missing title, failed' do
      visit stories_path
      fill_in 'story[content]', with: '123456'
      click_button 'Sumbit'
      expect(page).to have_content 'Error! Try again!'
    end
  end

  context 'edit story' do
    scenario 'successfully' do
      @story = FactoryBot.create(:story, @user)
      visit story_path(@story)
      fill_in 'story[title]', with: @story.title
      fill_in 'story[tag_list]', with: 'tag1, tag2'
      fill_in 'story[content]', with: @story.content
      click_button 'Sumbit'
      expect(page).to have_content 'Story was successfully updated.'
    end
  end

  context 'destroy story' do
    before(:each) do
      @story = FactoryBot.create(:story, @user)
    end

    scenario 'successfully' do
      visit story_path(@story)
      click_button 'Delete'
      click_button 'OK'
      expect(page).to have_content 'Story was successfully deleted.'
    end

    scenario 'cancel' do
      visit story_path(@story)
      click_button 'Delete'
      click_button 'Cancel'
      expect(page).to have_content @story.title
    end
  end
end
