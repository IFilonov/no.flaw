require 'rails_helper'

RSpec.describe Male, type: :model do
  it { is_expected.to belong_to(:female).optional }
  it { is_expected.to have_many(:females) }
  it { is_expected.to have_many(:lifetimes) }
  it { is_expected.to have_many(:pairs) }

  it { is_expected.to have_db_index :username }
  it { is_expected.to validate_presence_of :username }

  describe 'can' do
    let(:female) { create(:female) }
    let(:male) { create(:male, female: female) }

    it 'deletes the female' do
      male.delete_pair!

      expect(male.female).to be_nil
    end

    another_username = 'another_username'
    it 'update female' do
      male.update_pair!({ username: another_username, password: 'password', nickname: 'nick' })

      expect(male.female.username).to eq another_username
    end

    it 'restore female' do
      male.delete_pair!

      male.restore_pair!(female.id)

      expect(male.female.username).to eq female.username
      expect(male.pairs.last.female.id).to eq female.id
    end
  end
end
