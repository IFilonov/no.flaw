require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to have_many(:gender_tasks) }

  it { is_expected.to validate_presence_of :name }

  describe 'must' do
    let(:category) { create(:category) }

    it 'created' do
      expect(category.name).to eq('Category one')
    end
  end
end
