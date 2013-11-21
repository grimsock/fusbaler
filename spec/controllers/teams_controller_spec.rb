require 'spec_helper'

describe TeamsController do
  describe '#new' do
    let(:players) { build_list(:player, 2) }
    before do
      Player.stub(:all).and_return(players)
      get :new
    end

    it { expect(response).to be_success }
    it { expect(assigns(:players)).to eq(players) }
  end

  describe '#create' do
    context 'when valid attributes' do
      it 'saves team' do
        expect_any_instance_of(Team).to receive(:save)

        post :create, team: attributes_for(:team)
      end

      it 'redirects to team path' do 
        post :create, team: attributes_for(:team)
        t = assigns(:team)

        expect(response).to redirect_to team_path(t)
      end
    end

    context 'players' do
      let(:players) { build_list(:player, 2) }
      before do
        Player.stub(:all).and_return(players)
        expect_any_instance_of(Team).to receive(:save)
        post :create, team: attributes_for(:team)
      end
      
      it { expect(assigns(:players)).to eq(players) }
    end

    context 'when invalid attributes' do
      before { post :create, team: { name: '' } }

      it { expect(response).to render_template(:new) }
    end
  end

  describe '#show' do
    let(:team) { build_stubbed(:team) }

    context 'when team exists' do
      before do
        Team.stub(:find).and_return(team)
        get :show, id: team.id
      end

      it { expect(response).to be_success }
      it { expect(assigns(:team)).to eq(team) }
    end

    context 'when team does not exist' do
      before { get :show, id: team.id }

      it { expect(response).to be_not_found }
    end

    context 'players' do
      let(:players) { build_list(:player, 2) }
      before do
        Team.any_instance.stub(:players).and_return(players)
        Team.stub(:find).and_return(team)
        get :show, id: team.id
      end
      
      it { expect(assigns(:players)).to eq(players) }
    end
  end

  describe '#index' do
    context 'when teams exist' do
      let(:teams) { build_list(:team, 2) }
      before do
        Team.stub(:all).and_return(teams)
        get :index
      end

      it { expect(response).to be_success }
      it { expect(assigns(:teams)).to eq(teams) }
    end

    context 'when no teams' do
      before { get :index }

      it { expect(response).to be_success }
    end
  end

  describe '#edit' do
    let(:team) { build_stubbed(:team) }

    context 'when team exists' do
      let(:players) { build_list(:player, 2) }
      before do
        Player.stub(:all).and_return(players)
        Team.stub(:find).and_return(team)
        get :edit, id: team.id
      end

      it { expect(response).to be_success }
      it { expect(assigns(:players)).to eq(players) }
    end

    context 'when team does not exist' do
      before { get :show, id: team.id }

      it { expect(response).to be_not_found }
    end
  end

  describe '#update' do
    let(:team) { build_stubbed(:team) }

    context 'when valid attributes' do
      before { Team.stub(:find).and_return(team) }

      it 'updates team' do
        expect(team).to receive(:update)

        put :update, id: team.id, team: attributes_for(:team)
      end

      it 'redirects to team path' do 
        expect(team).to receive(:update).and_return(true)
        put :update, id: team.id, team: attributes_for(:team)

        expect(response).to redirect_to team_path(team)
      end
    end

    context 'players' do
      let(:players) { build_list(:player, 2) }
      before do
        Player.stub(:all).and_return(players)
        Team.stub(:find).and_return(team)
        expect(team).to receive(:update)
        put :update, id: team.id, team: attributes_for(:team)
      end

      it { expect(assigns(:players)).to eq(players) }
    end

    context 'when invalid attributes' do
      before do
        Team.stub(:find).and_return(team)
        expect(team).to receive(:update).and_return(false)
        put :update, id: team.id, team: { name: '' }
      end

      it { expect(response).to render_template(:edit) }
    end

    context 'when team does not exist' do
      let(:team) { build_stubbed(:team) }
      before { put :update, id: team.id, team: attributes_for(:team) }

      it { expect(response).to be_not_found }
    end
  end
end
