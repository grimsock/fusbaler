require 'spec_helper'

describe RankingController do
  describe '#index' do
    context 'when teams exist' do
      let(:ranking) { build(:default_ranking) }
      let(:ranking_position_1) { build(:ranking_position, ranking: ranking) }
      let(:ranking_position_2) { build(:ranking_position, ranking: ranking) }
      before do
        Ranking.stub_chain(:default, :first, :ranking_positions, :order).and_return([ranking_position_1, ranking_position_2])
        get :index
      end

      it { expect(response).to be_success }
      it { expect(assigns(:ranking_positions)).to eq([ranking_position_1, ranking_position_2]) }
    end

    context 'when no ranking positions' do
      let(:ranking) { build(:default_ranking) }
      before do
        Ranking.stub_chain(:default, :first).and_return(ranking)
        get :index
      end

      it { expect(response).to be_success }
    end
  end
end
