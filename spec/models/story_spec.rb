require 'rails_helper'

RSpec.describe Story, type: :model do
  before :all do
    @story = Story.create(title: 'Story one', content: 'Story content')
  end

  describe 'association' do
    it { should have_many(:taggings) }
    it { should have_many(:tags).through(:taggings) }
    it { should belong_to(:user) }
  end

  describe 'search title' do
    it 'should not find title' do
      expect(Story.search('Story two')).to_not eql('Story one')
    end
  end

  describe 'tag list' do
    it 'should add tags' do
      @story.tag_list = 'tag1, tag2, tag3'
      expect(@story.tags).to match_array([
                                           have_attributes(id: 1, name: 'tag1'),
                                           have_attributes(id: 2, name: 'tag2'),
                                           have_attributes(id: 3, name: 'tag3')
                                         ])
    end

    it 'should skip some tags' do
      @story.tag_list = 'tag1, tag2, tag3, tag4, tag5'
      expect(@story.tags).to match_array([
                                           have_attributes(id: 1, name: 'tag1'),
                                           have_attributes(id: 2, name: 'tag2'),
                                           have_attributes(id: 3, name: 'tag3'),
                                           have_attributes(id: 4, name: 'tag4'),
                                           have_attributes(id: 5, name: 'tag5')
                                         ])
    end
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:title).of_type(:string) }
    it { is_expected.to have_db_column(:content).of_type(:text) }
    it { is_expected.to have_db_column(:slug).of_type(:string) }
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end
end
