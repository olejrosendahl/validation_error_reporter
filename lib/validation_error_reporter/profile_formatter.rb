module ValidationErrorReporter
  class ProfileFormatter < Formatter

    def output(profile)
      "Summary:\n" +
      "Model with most errors: #{dump(profile, :rate)}.\n" +
      "Model with highest error rate: #{dump(profile, :count)}."
    end

    private

    def dump(profile, sort_attribute)
      sorted = profile.sort_by {|_, hash| -hash[sort_attribute]}.first
      model_name, stats = sorted[0], sorted[1]

      "#{model_name} (#{stats[:total]} entries, #{stats[:count]} errors, #{stats[:rate]}%)"
    end

  end
end
