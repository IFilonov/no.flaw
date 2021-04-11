require 'rails_helper'

RSpec.describe Male, type: :model do
  it { is_expected.to belong_to(:female).optional }
  it { is_expected.to have_many(:females) }
  it { is_expected.to have_many(:lifetimes) }
  it { is_expected.to have_many(:pairs) }

  it { is_expected.to have_db_index :username }
  it { is_expected.to validate_presence_of :username }

  describe 'can' do
    let!(:female) { create(:female) }
    let(:male) { create(:male, female: female) }

    it 'deletes the female' do
      male.delete_pair!

      expect(male.female).to be_nil
    end
  end
end
