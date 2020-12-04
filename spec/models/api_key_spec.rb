require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  describe 'columns' do
    it { is_expected.to have_db_column(:access_token).of_type(:string) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end
end
