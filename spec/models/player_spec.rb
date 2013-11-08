require 'spec_helper'

describe Player do
  context 'validations' do
    context 'name' do
      let(:name) { 'veryveryveryveryveryveryylongname' }
      before { create(:player, name: 'player') }

      it 'cannot be empty' do
        expect(build(:player, name: nil)).to_not be_valid
      end

      it 'cannot be duplicated' do
        expect(build(:player, name: 'player')).to_not be_valid
      end

      it 'cannot be more than 32 lenght' do
        expect(build(:player, name: name)).to_not be_valid
      end

      it 'creates valid player' do
        expect(build(:player, name: 'Player 1')).to be_valid
      end
    end
  end
end
