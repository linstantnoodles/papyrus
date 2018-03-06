class Card < ApplicationRecord
  validates_presence_of :front, :back

  after_initialize :set_defaults, if: :new_record?

  def review_with_performance_score(score)
    return self unless due_for_review?
    update_consecutive_correct_answers(score)
    update_easiness_factor(score)
    update_repetition_interval
    update_next_due_date
  end

  def repeat?(score)
    score < 3
  end

  def due_for_review?
    Time.now >= self.next_due_date
  end

  def set_defaults
    self.consecutive_correct_answers ||= 0
    self.easiness_factor ||= SpacedRepetition::DEFAULT_EASINESS_FACTOR
    self.repetition_interval ||= 0
    self.next_due_date ||= Time.now
  end

  def update_consecutive_correct_answers(score)
    self.consecutive_correct_answers = SpacedRepetition.repetition_count(self.consecutive_correct_answers, score)
    self
  end

  def update_easiness_factor(score)
    return unless score >= 3
    self.easiness_factor = SpacedRepetition.easiness_factor(self.easiness_factor, score)
    self
  end

  def update_repetition_interval
    self.repetition_interval = SpacedRepetition.interval(self.consecutive_correct_answers, self.easiness_factor)
    self
  end

  def update_next_due_date
    self.next_due_date = Time.now + self.repetition_interval.days
    self
  end
end
