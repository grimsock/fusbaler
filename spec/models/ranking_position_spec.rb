require 'spec_helper'

describe RankingPosition do
  context 'validations' do
    context 'ranking' do
      it { expect(build(:ranking_position, ranking: nil)).to_not be_valid }
    end

    context 'rank' do
      it { expect(build(:ranking_position, rank: nil)).to_not be_valid }
    end

    context 'team' do
      it { expect(build(:ranking_position, team: nil)).to_not be_valid }
    end
  end
end
