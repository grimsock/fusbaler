require 'spec_helper'

describe TeamsController do
  describe '#new' do
    before { get :new }

    it { expect(response).to be_success }
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
  end

  describe '#index' do
    context 'when teams exist' do
      let(:team_1) { build(:team) }
      let(:team_2) { build(:team) }
      before do
        Team.stub(:all).and_return([team_1, team_2])
        get :index
      end

      it { expect(response).to be_success }
      it { expect(assigns(:teams)).to eq([team_1, team_2]) }
    end

    context 'when no teams' do
      it { expect(response).to be_success }
    end
  end

  describe '#edit' do
    let(:team) { build_stubbed(:team) }

    context 'when team exists' do
      before do
        Team.stub(:find).and_return(team)
        get :edit, id: team.id
      end

      it { expect(response).to be_success }
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

  describe '#destroy' do
    let(:team) { build_stubbed(:team) }

    context 'when team exists' do
      before do
        Team.stub(:find).and_return(team)
        expect(team).to receive(:destroy)
        delete :destroy, id: team.id
      end

      it { expect(response).to redirect_to teams_path }
    end

    context 'when team does not exist' do
      before { delete :destroy, id: team.id }

      it { expect(response).to be_not_found }
    end
  end
end
