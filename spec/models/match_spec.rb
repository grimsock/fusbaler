require 'spec_helper'

describe Match do

  context 'validations' do
    context 'team_home' do
      it 'cannot be empty' do
        expect(build(:match, team_home: nil)).to_not be_valid
      end
    end

    context 'team_away' do
      it 'cannot be empty' do
        expect(build(:match, team_away: nil)).to_not be_valid
      end
    end

    context 'identical_teams?' do
      let(:team) { build(:team) }

      context 'when 2 the same teams for match' do
        it { expect(build(:match, team_home: team, team_away: team)).to_not be_valid }
      end
    end
  end

  describe '#teams' do
    let(:match) { build(:match) }
    it 'returns both teams' do
      expect(match.teams).to eq([match.team_home, match.team_away])
    end
  end
end
