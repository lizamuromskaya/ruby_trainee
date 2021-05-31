# frozen_string_literal: true

DATE = %r{[0-9]+/[A-z]+/[0-9]+:+[0-9]+:+[0-9]+:+[0-9]+\s+\+[0-9]*}.freeze
FROM = /^[0-9]+\.+[0-9]+\.+[0-9]+\.+[0-9]*/.freeze
TO = %r{/[a-z]+/[0-9]+/[a-z]+}.freeze

def task2(log)
  message = []
  lines = log.split("\n")
  lines.each do |string|
    date = string.scan(DATE).first
    next if date.nil?

    from = string.scan(FROM).first
    to = string.scan(TO).first.upcase!
    message << "DATE: #{date} FROM: #{from} TO: #{to}"
  end
  message
end
