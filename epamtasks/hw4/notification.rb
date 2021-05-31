# frozen_string_literal: true

# class notification
class Notification
  def initialize(message:)
    @message = message
  end

  private

  attr_reader :message
end
