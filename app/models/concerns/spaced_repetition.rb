module SpacedRepetition
  DEFAULT_EASINESS_FACTOR = 2.5
  MIN_EASINESS_FACTOR = 1.3

  def self.repetition_count(repetition_count, quality_of_response)
    return 1 if quality_of_response < 3
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