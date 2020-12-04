require 'rails_helper'

RSpec.describe User, type: :model do
  before :all do
    @user = User.create(full_name: 'Example Example', email: 'example@example.com', bio: 'example bo', image: 'image')
    @user2 = User.create(full_name: 'ExampleNew Example', email: 'example2@example.com', bio: 'example bo', image: 'image')
  end

  describe '#email' do
    it { expect(@user).to allow_value(@user.full_name).for(:full_name) }
    it { expect(@user).to allow_value(@user.email).for(:email) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to allow_value('example@example.com').for(:email) }
    it { is_expected.to_not allow_value('example').for(:email) }
    it { is_expected.to_not allow_value('example@').for(:email) }
  end

  describe 'association story' do
    it { should have_many(:stories) }
  end

  describe 'slug' do
    it 'should create slug from full name' do
      expect(@user.create_slug).to eql('Example-E')
    end
  end

  describe 'role' do
    it 'should be an admin as first user' do
      expect(@user.set_admin).to eql(:admin)
    end

    it 'should not be an admin' do
      expect(@user2).to_not eql(:admin)
    end

    it 'should be an author by default' do
      expect(@user2.role).to eql('author')
    end

    it 'should be a editor' do
      @user2.role = 2
      expect(@user2.role).to eql('editor')
    end

    it 'should be an author' do
      @user2.role = 1
      expect(@user2.role).to eql('author')
    end

    it 'should be an admin' do
      @user2.role = 0
      expect(@user2.role).to eql('admin')
    end

    describe 'callback' do
      it { expect(@user).to callback(:create_slug).before(:create) }
      it { expect(@user).to callback(:create_slug).before(:update) }
      it { expect(@user).to callback(:set_admin).before(:create) }
    end

    describe 'columns' do
      it { is_expected.to have_db_column(:email).of_type(:string) }
      it { is_expected.to have_db_column(:role).of_type(:integer) }
      it { is_expected.to have_db_column(:full_name).of_type(:string) }
      it { is_expected.to have_db_column(:slug).of_type(:string) }
      it { is_expected.to have_db_column(:bio).of_type(:text) }
      it { is_expected.to have_db_column(:image).of_type(:string) }
      it { is_expected.to have_db_column(:encrypted_password).of_type(:string) }
      it { is_expected.to have_db_column(:reset_password_token).of_type(:string) }
      it { is_expected.to have_db_column(:reset_password_sent_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:remember_created_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:invitation_token).of_type(:string) }
      it { is_expected.to have_db_column(:invitation_created_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:invitation_sent_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:invitation_accepted_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:invitation_limit).of_type(:integer) }
      it { is_expected.to have_db_column(:invited_by_type).of_type(:string) }
      it { is_expected.to have_db_column(:invited_by_id).of_type(:integer) }
      it { is_expected.to have_db_column(:invitations_count).of_type(:integer) }
      it { is_expected.to have_db_column(:sign_in_count).of_type(:integer) }
      it { is_expected.to have_db_column(:current_sign_in_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:last_sign_in_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:deleted_at).of_type(:datetime) }
    end
  end
end
