require 'spec_helper'

describe PlayersController do
  describe '#new' do
    before { get :new }

    it { expect(response).to be_success }
  end

  describe '#create' do
    context 'when valid attributes' do
      it 'saves player' do
        expect_any_instance_of(Player).to receive(:save)

        post :create, player: attributes_for(:player)
      end

      it 'redirects to player path' do 
        post :create, player: attributes_for(:player)
        p = assigns(:player)

        expect(response).to redirect_to player_path(p)
      end
    end

    context 'when invalid attributes' do
      before { post :create, player: { name: '' } }

      it { expect(response).to render_template(:new) }
    end
  end

  describe '#show' do
    let(:player) { build_stubbed(:player) }

    context 'when player exists' do
      before do
        Player.stub(:find).and_return(player)
        get :show, id: player.id
      end

      it { expect(response).to be_success }
      it { expect(assigns(:player)).to eq(player) }
    end

    context 'when player does not exist' do
      before { get :show, id: player.id }

      it { expect(response).to be_not_found }
    end
  end

  describe '#index' do
    context 'when players exist' do
      let(:player_1) { build(:player) }
      let(:player_2) { build(:player) }
      before do
        Player.stub(:all).and_return([player_1, player_2])
        get :index
      end

      it { expect(response).to be_success }
      it { expect(assigns(:players)).to eq([player_1, player_2]) }
    end

    context 'when no players' do
      it { expect(response).to be_success }
    end
  end

  describe '#edit' do
    let(:player) { build_stubbed(:player) }

    context 'when player exists' do
      before do
        Player.stub(:find).and_return(player)
        get :edit, id: player.id
      end

      it { expect(response).to be_success }
    end

    context 'when player does not exist' do
      before { get :show, id: player.id }

      it { expect(response).to be_not_found }
    end
  end

  describe '#update' do
    let(:player) { build_stubbed(:player) }

    context 'when valid attributes' do
      before { Player.stub(:find).and_return(player) }

      it 'updates player' do
        expect(player).to receive(:update)

        put :update, id: player.id, player: attributes_for(:player)
      end

      it 'redirects to player path' do 
        expect(player).to receive(:update).and_return(true)
        put :update, id: player.id, player: attributes_for(:player)

        expect(response).to redirect_to player_path(player)
      end
    end

    context 'when invalid attributes' do
      before do
        Player.stub(:find).and_return(player)
        expect(player).to receive(:update).and_return(false)
        put :update, id: player.id, player: { name: '' }
      end

      it { expect(response).to render_template(:edit) }
    end

    context 'when player does not exist' do
      let(:player) { build_stubbed(:player) }
      before { put :update, id: player.id, player: attributes_for(:player) }

      it { expect(response).to be_not_found }
    end
  end
end
