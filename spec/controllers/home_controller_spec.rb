require 'spec_helper'

describe HomeController do
  describe '#index' do
    before do
      controller.stub(:authorize_user).and_return(true)
      get :index
    end

    it { expect(response).to be_success }
  end
end
