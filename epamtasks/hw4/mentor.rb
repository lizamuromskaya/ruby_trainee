# frozen_string_literal: true

require './human'
# The class that is responsible for the mentor's actions
class Mentor < Human
  def initialize(name:, surname:)
    super
    @students = []
    @notifications = []
  end

  def subscribe_to(student)
    student.mentors << self
    @students << student
  end

  def task_for_student(title, data, student)
    homework = Homework.new(title: title, data: data, student: student)
    student.to_work(homework)
    homework
  end

  def notify_students(notification)
    @students.each do |student|
      student.notifications << notification
    end
  end

  def add_new_task(homework)
    notification = Notification.new(message: 'Add a new task!')
    notify_students(notification)
    homework.given
  end

  def reject_to_work(homework)
    notification = Notification.new(message: 'Rejected!')
    notify_students(notification)
    homework.rejecting
  end

  def accept_to_work(homework)
    notification = Notification.new(message: 'Accepted!')
    notify_students(notification)
    homework.accepting
  end

  private

  attr_reader :students
end
