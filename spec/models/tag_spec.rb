require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'association' do
    it { should have_many(:taggings) }
    it { should have_many(:stories).through(:taggings) }
  end
  describe 'columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end
end
