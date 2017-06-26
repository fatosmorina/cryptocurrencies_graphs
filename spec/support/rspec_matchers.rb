RSpec::Matchers.define :schedule_rake do |task|
  match do |whenever|
    jobs = whenever.instance_variable_get("@jobs")
    key = @duration.is_a?(ActiveSupport::Duration) ? @duration.to_i : @duration

    if jobs.has_key?(key)
      jobs[key].any? do |job|
        options = job.instance_variable_get("@options")

        options[:task] == task && (@time.present? ? job.at == @time : true)
      end
    else
      false
    end
  end

  chain :every do |duration|
    @duration = duration
  end

  chain :at do |time|
    @time = time
  end

  failure_message do |actual|
    "Expected whenever to schedule #{ task } every #{ @duration } seconds"
  end

  failure_message_when_negated do |actual|
    "Expected whenever not to schedule #{ task } every #{ @duration } seconds"
  end
end

RSpec::Matchers.alias_matcher :schedule_runner, :schedule_rake
RSpec::Matchers.alias_matcher :schedule_command, :schedule_rake