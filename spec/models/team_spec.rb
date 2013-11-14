require 'spec_helper'

describe Team do
  context 'validations' do
    context 'name' do
      let(:name) { 'veryveryveryveryveryveryylongname' }
      before { create(:team, name: 'team') }

      it 'cannot be empty' do
        expect(build(:team, name: nil)).to_not be_valid
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

    context 'team_players_limit' do
      context 'when more than 2 players' do
        let(:players) { build_list(:player, 3) }

        it { expect(build(:team, players: players)).to_not be_valid }
      end

      context 'when 2 players' do
        let(:players) { build_list(:player, 2) }

        it { expect(build(:team, players: players)).to be_valid }
      end
    end
  end

  describe '#matches' do
    let(:team) { create(:team) }
    let(:ranking) { build(:default_ranking) }
    before do
      Ranking.stub_chain(:default, :first).and_return(ranking)
    end

    context 'when team has home and away matches' do
      let(:matches) { [] << create(:match, team_home: team) << create(:match, team_away: team) }

      it 'returns all matches' do
        expect(team.matches).to eq(matches)
      end
    end

    context 'when team has only home match' do
      let(:matches) { [] << create(:match, team_home: team) }

      it 'returns all matches' do
        expect(team.matches).to eq(matches)
      end
    end
  end
end
