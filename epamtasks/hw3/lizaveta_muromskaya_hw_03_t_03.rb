# frozen_string_literal: true

# This is class for task3
class Task
  TIME = /[0-9]+:[0-9]+:[0-9]+\.[0-9]/.freeze
  def time_in_sec(time)
    time.each do |time_numbers|
      time_buf = time_numbers.split(':')
      sec = time_buf[0].to_f * 3600 + time_buf[1].to_f * 60 + time_buf[2].to_f
      @seconds << sec
    end
    @seconds
  end

  def time_difference
    @seconds.each_cons(2) do |start_event, end_event|
      res = end_event - start_event
      @result << res.round(1).to_s if res.positive?
    end
    @result
  end

  def task3(log)
    @seconds = []
    @result = []
    lines = log.split("\n")
    lines.each do |string|
      time = string.scan(TIME) if string.include?('Calling core with action:')
      next if time.nil?

      time_in_sec(time)
    end
    time_difference
    if @result.empty?
      '0'
    elsif @result.size == 1
      @result[0]
    else
      @result
    end
  end
end
