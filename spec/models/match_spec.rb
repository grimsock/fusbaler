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
      let(:other_team) { build(:team) }

      context 'when 2 the same teams for match' do
        it { expect(build(:match, team_home: team, team_away: team)).to_not be_valid }
      end

      context 'when 2 different teams for match' do
        it { expect(build(:match, team_home: team, team_away: other_team)).to be_valid }
      end
    end
  end

  describe '#autosave_associated_records_for_score' do
    let(:score) { build(:score, score_home: 5, score_away: 3) }
    let!(:default_ranking) { create(:default_ranking) }
    let(:match) { build(:match, score: score) }

    context 'when score exists' do
      let!(:score_existing) { create(:score, score_home: 5, score_away: 3) }

      it { expect(match.autosave_associated_records_for_score).to eq(score_existing) }
      it { expect { match.autosave_associated_records_for_score }.to_not change{Score.count} }
    end

    context 'when score does not exist' do
      it { expect { match.autosave_associated_records_for_score }.to change{Score.count}.by(1) }
    end
  end

  describe '#set_rank' do
    context 'when match score is not a draw' do
      let(:score) { build(:score, score_home: 5, score_away: 3) }

      context 'when ranking position exists' do
        let(:team) { build(:team) }
        let(:match) { build(:match, team_home: team, score: score) }
        let!(:ranking_position) { create(:ranking_position, team: team, rank: 3, ranking: default_ranking) }
        let(:default_ranking) { create(:default_ranking) }

        it { expect { match.set_rank }.to change{ranking_position.reload.rank}.by(1) }
        it { expect { match.set_rank }.to_not change{RankingPosition.count}.by(1) }
      end

      context 'when ranking position does not exist' do
        let(:team) { build(:team) }
        let(:match) { build(:match, team_home: team, score: score) }
        let(:ranking_position) { build(:ranking_position) }
        let!(:default_ranking) { create(:default_ranking) }

        it { expect(match.set_rank.rank).to be(1) }
        it { expect(match.set_rank.team_id).to be(team.id) }
        it { expect { match.set_rank }.to change{RankingPosition.count}.by(1) }
      end
    end

    context 'when match score is draw' do
      let(:score) { build(:score, score_home: 5, score_away: 5) }
      let(:match) { build(:match, score: score) }

      it 'deos not invoke find_by_team_id and craete!' do
        expect(RankingPosition).to_not receive(:find_by_team_id)
        expect(RankingPosition).to_not receive(:create!)
        match.set_rank
      end
    end
  end

  describe '#draw?' do
    context 'when match score is draw' do
      let(:score) { build(:score, score_home: 3, score_away: 3) }

      it { expect(build(:match, score: score).draw?).to be_true }
    end

    context 'when match score is not a draw' do
      let(:score) { create(:score, score_home: 6, score_away: 3) }

      it { expect(build(:match, score: score).draw?).to be_false }
    end
  end

  describe '#winner' do
    let(:match) { build(:match, score: score) }

    context 'when match won by home team' do
      let(:score) { build(:score, score_home: 6, score_away: 3) }

      it { expect(match.winner).to be(match.team_home) }
    end

    context 'when match won by away team' do
      let(:score) { build(:score, score_home: 1, score_away: 5) }

      it { expect(match.winner).to be(match.team_away) }
    end

    context 'when draw' do
      let(:score) { build(:score, score_home: 1, score_away: 1) }

      it { expect(match.winner).to be_nil }
    end
  end

  describe '#teams' do
    let(:match) { build(:match) }

    it 'returns both teams' do
      expect(match.teams).to eq([match.team_home, match.team_away])
    end
  end
end
