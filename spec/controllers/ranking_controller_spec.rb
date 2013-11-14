require 'spec_helper'

describe RankingController do
  describe '#index' do
    context 'when teams exist' do
      let(:ranking) { create(:default_ranking) }
      let!(:ranking_position_1) { create(:ranking_position, rank: 1, ranking: ranking) }
      let!(:ranking_position_2) { create(:ranking_position, rank: 3, ranking: ranking) }
      before do
        get :index
      end

      it { expect(response).to be_success }
      it { expect(assigns(:ranking_positions)).to eq([ranking_position_2, ranking_position_1]) }
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
