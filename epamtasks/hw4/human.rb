# frozen_string_literal: true

# Base class Human
class Human
  attr_reader :name, :surname, :notifications

  def initialize(name:, surname:)
    @name = name
    @surname = surname
    @notifications = []
  end

  def show_notifications
    notifications.each { |notification| p notification }
  end

  def read_notifications
    notifications.clear
  end
end
