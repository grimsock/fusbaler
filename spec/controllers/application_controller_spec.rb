require 'spec_helper'

describe ApplicationController do
  controller do
    def index
      render nothing: true
    end
  end

  describe '#authorize_user' do
    context 'when user set in session' do
      before do
        session.stub(:[]).with("flash")
        session.stub(:[]).with(:_turbolinks_redirect_to)
        session.stub(:[]).with(:user_id).and_return 1
        get :index
      end

      it { expect(response).to be_success }
    end

    context 'when user not set in session' do
      before { get :index }

      it { expect(response).to redirect_to login_path }
    end
  end
end
