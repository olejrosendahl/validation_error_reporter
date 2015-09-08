module ValidationErrorReporter
  class Profiler

    def initialize
      @profile = Hash.new { |h, k| h[k] = { count: 0, total: 0 } }
    end

    def profile(errors)
      errors.each do |error|
        @profile[error.model_name][:count] += 1
        @profile[error.model_name][:total] = error.model_total_count
      end

      @profile.each_value do |hash|
        hash[:rate] = hash[:count].to_f / hash[:total].to_f * 100
      end

      @profile
    end

  end
end
