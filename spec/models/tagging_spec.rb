require 'rails_helper'

RSpec.describe Tagging, type: :model do
  describe 'association' do
    it { should belong_to(:tag) }
    it { should belong_to(:story) }
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:tag_id).of_type(:integer) }
    it { is_expected.to have_db_column(:story_id).of_type(:integer) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end
end
