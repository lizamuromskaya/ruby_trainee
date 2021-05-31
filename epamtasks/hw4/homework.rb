# frozen_string_literal: true

# class homework
class Homework
  CREATING = 'Homework is create'
  GIVEN = 'Homework is given'
  REJECTING = 'Homework is reject'
  ACCEPTING = 'Homework is accept'
  attr_reader :title, :data
  attr_accessor :answer

  def initialize(title:, data:, student:, status: CREATING, answer: nil)
    @title = title
    @data = data
    @student = student
    @status = status
    @answer = answer
  end

  def change_status(new_status)
    @status = new_status
  end

  def given
    change_status(GIVEN)
  end

  def rejecting
    change_status(REJECTING)
  end

  def accepting
    change_status(ACCEPTING)
  end
end
