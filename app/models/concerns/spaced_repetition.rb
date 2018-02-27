module SpacedRepetition
  DEFAULT_EASINESS_FACTOR = 2.5
  MIN_EASINESS_FACTOR = 1.3

  def self.interval(finished_repetitions, easiness_factor)
    return 1 if finished_repetitions < 1
    return 6 if finished_repetitions == 1
    interval((finished_repetitions - 1), easiness_factor) * easiness_factor
  end

  def self.easiness_factor(easiness_factor, quality_of_response)
    return MIN_EASINESS_FACTOR unless easiness_factor > MIN_EASINESS_FACTOR
    (easiness_factor + (0.1 - (5 - quality_of_response) * (0.08 + (5 - quality_of_response) * 0.02)))
  end
end