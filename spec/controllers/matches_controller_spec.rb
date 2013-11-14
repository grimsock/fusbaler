require 'spec_helper'

describe MatchesController do
  describe '#new' do
    let(:teams) { build_list(:team, 2) }
    before do
      Team.stub(:all).and_return(teams)
      get :new
    end

    it { expect(response).to be_success }
    it { expect(assigns(:teams)).to eq(teams) }
  end

  describe '#create' do
    context 'when valid attributes' do
      let(:team_1) { create(:team) }
      let(:team_2) { create(:team) }
      let(:ranking) { build(:default_ranking) }
      before do
        Ranking.stub_chain(:default, :first).and_return(ranking)
      end

      it 'saves match' do
        expect_any_instance_of(Match).to receive(:save)

        post :create, match: { team_home_id: team_1.id, team_away_id: team_2.id, score_attributes: { score_home: 2, score_away: 4 } }
      end

      it 'redirects to match path' do 
        post :create, match: { team_home_id: team_1.id, team_away_id: team_2.id, score_attributes: { score_home: 2, score_away: 4 } }
        m = assigns(:match)

        expect(response).to redirect_to match_path(m)
      end
    end

    context 'teams' do
      let(:teams) { build_list(:team, 2) }
      before do
        Team.stub(:all).and_return(teams)
        expect_any_instance_of(Match).to receive(:save)
        post :create, match: { team_home_id: 1, team_away_id: 2 }
      end
      
      it { expect(assigns(:teams)).to eq(teams) }
    end

    context 'when invalid attributes' do
      before { post :create, match: { team_home: '' } }

      it { expect(response).to render_template(:new) }
    end
  end

  describe '#show' do
    let(:match) { build_stubbed(:match) }

    context 'when match exists' do
      before do
        Match.stub(:find).and_return(match)
        get :show, id: match.id
      end

      it { expect(response).to be_success }
      it { expect(assigns(:match)).to eq(match) }
    end

    context 'when team does not exist' do
      before { get :show, id: match.id }

      it { expect(response).to be_not_found }
    end
  end

  describe '#index' do
    context 'when matches exist' do
      let(:matches) { build_list(:match, 2) }
      before do
        Match.stub(:all).and_return(matches)
        get :index
      end

      it { expect(response).to be_success }
      it { expect(assigns(:matches)).to eq(matches) }
    end

    context 'when no teams' do
      before { get :index }

      it { expect(response).to be_success }
    end
  end

  describe '#edit' do
    let(:match) { build_stubbed(:match) }

    context 'when match exists' do
      let(:teams) { build_list(:team, 2) }
      before do
        Team.stub(:all).and_return(teams)
        Match.stub(:find).and_return(match)
        get :edit, id: match.id
      end

      it { expect(response).to be_success }
      it { expect(assigns(:teams)).to eq(teams) }
    end

    context 'when match does not exist' do
      before { get :show, id: match.id }

      it { expect(response).to be_not_found }
    end
  end

  describe '#update' do
    let(:match) { build_stubbed(:match) }

    context 'when valid attributes' do
      let(:team_1) { create(:team) }
      let(:team_2) { create(:team) }
      let(:ranking) { build(:default_ranking) }
      before do
        Match.stub(:find).and_return(match)
        Ranking.stub_chain(:default, :first).and_return(ranking)
      end

      it 'updates match' do
        expect(match).to receive(:update)

        put :update, id: match.id, match: { team_home_id: team_1.id, team_away_id: team_2.id, score_attributes: { score_home: 2, score_away: 4 } }
      end

      it 'redirects to match path' do 
        expect(match).to receive(:update).and_return(true)
        put :update, id: match.id, match: { team_home_id: team_1.id, team_away_id: team_2.id, score_attributes: { score_home: 2, score_away: 4 } }

        expect(response).to redirect_to match_path(match)
      end
    end

    context 'teams' do
      let(:teams) { build_list(:team, 2) }
      before do
        Team.stub(:all).and_return(teams)
        Match.stub(:find).and_return(match)
        expect(match).to receive(:update)
        put :update, id: match.id, match: { team_home_id: 1, team_away_id: 2 }
      end

      it { expect(assigns(:teams)).to eq(teams) }
    end

    context 'when invalid attributes' do
      before do
        Match.stub(:find).and_return(match)
        expect(match).to receive(:update).and_return(false)
        put :update, id: match.id, match: { team_home: '' }
      end

      it { expect(response).to render_template(:edit) }
    end

    context 'when match does not exist' do
      let(:match) { build_stubbed(:match) }
      before { put :update, id: match.id, match: attributes_for(:match) }

      it { expect(response).to be_not_found }
    end
  end
end
