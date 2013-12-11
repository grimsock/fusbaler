require 'spec_helper'

describe ApplicationHelper do
  describe '#go_back' do
    context 'when referer' do
      before { controller.request.stub(:referer).and_return('http://example.com/test/path') }

      it { expect(helper.go_back).to eq('/test/path') }
    end

    context 'when no referer' do
      before { controller.request.stub(:referer).and_return(nil) }

      it { expect(helper.go_back).to be_nil }
    end
  end
end
