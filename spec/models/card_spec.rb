require 'rails_helper'

RSpec.describe Card, type: :model do
  subject {
    described_class.new(
      front: 'test-front',
      back: 'test-back',
    )
   }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a front" do
    subject.front = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a back" do
    subject.back = nil
    expect(subject).to_not be_valid
  end

  describe 'due_for_review?' do
    context 'when current date equals or greater than next due date' do
      it 'returns true' do
        card = Card.create(front: 'test', back: 'test', next_due_date: 2.days.ago)

        expect(card.due_for_review?).to eq(true)
      end

      context 'when dates are equal but different times' do
        it 'returns true' do
          current_time = Time.new(2018, 6, 21, 13,30,0)
          due_time = current_time + 30.minutes
          allow(Time).to receive(:now).and_return(current_time)

          card = Card.create(front: 'test', back: 'test', next_due_date: due_time)

          expect(card.due_for_review?).to eq(true)
        end
      end
    end

    context 'when current date earlier than next due date' do
      it 'returns false' do
        card = Card.create(front: 'test', back: 'test', next_due_date: 2.days.from_now)

        expect(card.due_for_review?).to eq(false)
      end
    end
  end

  describe 'update_consecutive_correct_answers' do
    it 'updates the consecutive_correct_answers' do
      @card = Card.create(front: 'test', back: 'test', consecutive_correct_answers: 0)

      allow(SpacedRepetition).to receive(:repetition_count).and_call_original

      @card.update_consecutive_correct_answers(3)

      expect(@card.consecutive_correct_answers).to eq(1)
      expect(SpacedRepetition).to have_received(:repetition_count).with(0, 3)
    end
  end

  describe 'update_easiness_factor' do
    context 'when performance is equal or greater than 3' do
      it 'updates the easiness_factor' do
        @card = Card.create(front: 'test', back: 'test', easiness_factor: 2.5)

        allow(SpacedRepetition).to receive(:easiness_factor).and_call_original

        @card.update_easiness_factor(3)

        expect(@card.easiness_factor.to_f).to eq(2.36)
        expect(SpacedRepetition).to have_received(:easiness_factor).with(2.5, 3)
      end
    end

    context 'when score is lower than 3' do
      it 'does not update the easiness_factor' do
        @card = Card.create(front: 'test', back: 'test', easiness_factor: 2.5)

        allow(SpacedRepetition).to receive(:easiness_factor)

        @card.update_easiness_factor(2)

        expect(@card.easiness_factor).to eq(2.5)
        expect(SpacedRepetition).to_not have_received(:easiness_factor)
      end
    end
  end

  describe 'update_interval' do
    it 'updates the interval' do
      @card = Card.create(front: 'test', back: 'test', consecutive_correct_answers: 0, repetition_interval: 0, easiness_factor: 1.3)

      allow(SpacedRepetition).to receive(:interval).and_call_original

      @card.update_repetition_interval

      expect(@card.repetition_interval).to eq(1)
      expect(SpacedRepetition).to have_received(:interval).with(0, 1.3)
    end
  end

  describe 'update_next_due_date' do
    it 'updates the next_due_date' do
      current_time = Time.now
      allow(Time).to receive(:now).and_return(current_time)
      @card = Card.create(front: 'test', back: 'test', repetition_interval: 2)

      @card.update_next_due_date

      expect(@card.next_due_date).to eq(current_time + 2.days)
    end
  end

  describe 'review_with_performance_score' do
    before do
      @card = Card.create(front: 'test', back: 'test', consecutive_correct_answers: 0)
    end

    context 'when card is not yet due for review' do
      it 'does not update anything' do
        allow(@card).to receive(:due_for_review?).and_return(false)
        allow(@card).to receive(:update_consecutive_correct_answers)
        allow(@card).to receive(:update_easiness_factor)
        allow(@card).to receive(:update_repetition_interval)
        allow(@card).to receive(:update_next_due_date)

        @card.review_with_performance_score(3)

        expect(@card).to_not have_received(:update_consecutive_correct_answers)
        expect(@card).to_not have_received(:update_easiness_factor)
        expect(@card).to_not have_received(:update_repetition_interval)
        expect(@card).to_not have_received(:update_next_due_date)
      end
    end

    context 'when card is due for review' do
      it 'updates everything' do
        allow(@card).to receive(:due_for_review?).and_return(true)
        allow(@card).to receive(:update_consecutive_correct_answers)
        allow(@card).to receive(:update_easiness_factor)
        allow(@card).to receive(:update_repetition_interval)
        allow(@card).to receive(:update_next_due_date)

        @card.review_with_performance_score(3)

        expect(@card).to have_received(:update_consecutive_correct_answers)
        expect(@card).to have_received(:update_easiness_factor)
        expect(@card).to have_received(:update_repetition_interval)
        expect(@card).to have_received(:update_next_due_date)
      end
    end
  end
end
