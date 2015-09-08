module ValidationErrorReporter
  class ProfileFormatter < Formatter

    def format(profile)
      return "No errors" if profile.empty?

      "Summary:\n" +
      "Model with most errors: #{dump(profile, :count)}.\n" +
      "Model with highest error rate: #{dump(profile, :rate)}."
    end

    private

    def dump(profile, sort_attribute)
      sorted = profile.sort_by {|_, hash| -hash[sort_attribute]}.first
      model_name, stats = sorted[0], sorted[1]

      "#{model_name} (#{stats[:total]} entries, #{stats[:count]} errors, #{stats[:rate]}%)"
    end

  end
end
