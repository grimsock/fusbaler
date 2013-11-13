require 'spec_helper'

describe Score do
  context 'validations' do
    context 'score_home' do
      it 'cannot be empty' do
        expect(build(:score, score_home: nil)).to_not be_valid
      end

      it 'cannot be less than 0' do
        expect(build(:score, score_home: -1)).to_not be_valid
      end

      it 'cannot be greater than 10' do
        expect(build(:score, score_home: 11)).to_not be_valid
      end

      it 'should be integer' do
        expect(build(:score, score_home: 1.345)).to_not be_valid
      end

      it 'creates valid score' do
        expect(build(:score, score_home: 5)).to be_valid
      end
    end

    context 'score_away' do
      it 'cannot be empty' do
        expect(build(:score, score_away: nil)).to_not be_valid
      end

      it 'cannot be less than 0' do
        expect(build(:score, score_away: -1)).to_not be_valid
      end

      it 'cannot be greater than 10' do
        expect(build(:score, score_away: 11)).to_not be_valid
      end

      it 'should be integer' do
        expect(build(:score, score_away: 1.345)).to_not be_valid
      end

      it 'creates valid score' do
        expect(build(:score, score_away: 5)).to be_valid
      end
    end
  end
end
