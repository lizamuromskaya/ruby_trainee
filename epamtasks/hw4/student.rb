# frozen_string_literal: true

require './human'
require './mentor'
require './homework'
require './notification'

# This class is responsible for the student's actions
class Student < Human
  attr_reader :mentors

  def initialize(name:, surname:)
    super
    @homeworks = []
    @mentors = []
    @notifications = []
  end

  def show_homeworks
    @homeworks.each { |homework| p homework }
  end

  def to_work(homework_task)
    @homework = homework_task
    @homeworks << @homework
  end

  def add_answer(homework, answer)
    homework.answer = answer
  end

  def to_check
    notification = Notification.new(message: "#{@homework.title} is done!")
    @mentors.each do |mentor|
      mentor.notifications << notification
    end
  end

  private

  attr_reader :homeworks
end
