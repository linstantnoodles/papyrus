module SpacedRepetition
  extend ActiveSupport::Concern

  DEFAULT_EASINESS_FACTOR = 2.5
  MIN_EASINESS_FACTOR = 1.3
  CORRECT_SCORE = 3

  included do
    after_initialize :set_defaults, if: :new_record?

    def review_with_performance_score(score)
      return self unless due_for_review?
      update_consecutive_correct_answers(score)
      update_easiness_factor(score)
      update_repetition_interval
      update_next_due_date
    end

    def repeat?(score)
      score < SpacedRepetition::CORRECT_SCORE
    end

    def due_for_review?
      Time.now.to_date >= self.next_due_date.to_date
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
      return unless score >= SpacedRepetition::CORRECT_SCORE
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

  def self.repetition_count(repetition_count, quality_of_response)
    return 0 if quality_of_response < SpacedRepetition::CORRECT_SCORE
    repetition_count + 1
  end

  def self.interval(repetition_count, easiness_factor)
    return 1 if repetition_count == 0
    return 6 if repetition_count == 1
    interval((repetition_count - 1), easiness_factor) * easiness_factor
  end

  def self.easiness_factor(easiness_factor, quality_of_response)
    updated_easiness_factor = (easiness_factor + (0.1 - (5 - quality_of_response) * (0.08 + (5 - quality_of_response) * 0.02)))
    return MIN_EASINESS_FACTOR unless updated_easiness_factor > MIN_EASINESS_FACTOR
    updated_easiness_factor
  end
end