class Card < ApplicationRecord
  validates_presence_of :front, :back

  after_initialize :set_defaults, if: :new_record?

  def set_defaults
    self.consecutive_correct_answers ||= 0
    self.easiness_factor ||= SpacedRepetition::DEFAULT_EASINESS_FACTOR
    self.repetition_interval ||= 0
  end

  def review_with_performance_score(score)
    update_consecutive_correct_answers(score)
    if score >= 3
      update_easiness_factor(score)
    end
    update_repetition_interval
    update_next_due_date
  end

  def update_consecutive_correct_answers(score)
    self.consecutive_correct_answers = SpacedRepetition.repetition_count(self.consecutive_correct_answers, score)
  end

  def update_easiness_factor(score)
    self.easiness_factor = SpacedRepetition.easiness_factor(self.easiness_factor, score)
  end

  def update_repetition_interval
    self.repetition_interval = SpacedRepetition.interval(self.consecutive_correct_answers, self.easiness_factor)
  end

  def update_next_due_date
    self.next_due_date = Time.now + self.repetition_interval.days
  end
end
