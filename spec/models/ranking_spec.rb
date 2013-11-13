require 'spec_helper'

describe Ranking do
  context 'validations' do
    context 'name' do
      it { expect(build(:ranking, name: nil)).to_not be_valid }
      it { expect(build(:ranking, name: 'ranking')).to be_valid }
    end
  end
end
