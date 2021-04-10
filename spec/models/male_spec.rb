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
    # let(:question) { create(:question, user: user) }
    # let(:answer) { create(:answer, question: question, user: user) }
    # let(:another_answer) { create(:answer, question: question, user: another_user) }
    # let!(:reward) { create(:reward, question: question) }

    it 'deletes the female' do
      male.delete_pair!

      expect(male.female).to be_nil
    end

    # it 'only one answer can be the best' do
    #   another_answer = create(:answer, question: question, user: user, best: true)
    #
    #   expect(another_answer).to be_best
    #
    #   answer.best!
    #   another_answer.reload
    #
    #   expect(answer).to be_best
    #   expect(another_answer).to_not be_best
    # end
  end
end
