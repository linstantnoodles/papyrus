require 'rails_helper'

RSpec.describe SpacedRepetition do
  it 'returns default easiness factor' do
    expect(SpacedRepetition::DEFAULT_EASINESS_FACTOR).to eq(2.5)
  end

  describe '#interval' do
    context 'when finished no repetitions' do
      it 'returns 1' do
        finished_repetitions = 0
        easiness_factor = 2.5
        expect(SpacedRepetition.interval(finished_repetitions, easiness_factor)).to eq(1)
      end
    end

    context 'when finished 1 repetition' do
      it 'returns 6' do
        finished_repetitions = 1
        easiness_factor = 2.5
        expect(SpacedRepetition.interval(finished_repetitions, easiness_factor)).to eq(6)
      end
    end

    context 'when after second interval' do
      it 'returns correct days based on easiness factor' do
        finished_repetitions = 2
        easiness_factor = 2.5
        expect(SpacedRepetition.interval(finished_repetitions, easiness_factor)).to eq(6 * easiness_factor)
      end
    end
  end

  describe '#easiness_factor' do
    context 'when quality of response equals 4' do
      it 'does not change' do
        easiness_factor = 2.5
        quality_of_response = 4
        expect(SpacedRepetition.easiness_factor(easiness_factor, quality_of_response)).to eq(2.5)
      end
    end

    context 'when quality of response is less than 4' do
      it 'does not change' do
        easiness_factor = 2.5
        quality_of_response = 3
        expect(SpacedRepetition.easiness_factor(easiness_factor, quality_of_response)).to be < 2.5
      end
    end

    context 'when quality of response is greater than 4' do
      it 'does not change' do
        easiness_factor = 2.5
        quality_of_response = 5
        expect(SpacedRepetition.easiness_factor(easiness_factor, quality_of_response)).to be > 2.5
      end
    end

    context 'when easiness factor is less than 1.3' do
      it 'returns 1.3' do
        easiness_factor = 1.0
        quality_of_response = 0
        expect(SpacedRepetition.easiness_factor(easiness_factor, quality_of_response)).to eq(1.3)
      end
    end
  end
end

