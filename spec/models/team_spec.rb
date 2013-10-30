require 'spec_helper'

describe Team do
  context 'validations' do
    context 'name' do
      let(:name) { 'veryveryveryveryveryveryylongname' }
      before { create(:team, name: 'team') }

      it 'cannot be empty' do
        expect(build(:team, name: '')).to_not be_valid
      end

      it 'cannot be duplicated' do
        expect(build(:team, name: 'team')).to_not be_valid
      end

      it 'cannot be more than 32 lenght' do
        expect(build(:team, name: name)).to_not be_valid
      end

      it 'creates valid player' do
        expect(build(:team, name: 'Team 1')).to be_valid
      end
    end
  end
end
