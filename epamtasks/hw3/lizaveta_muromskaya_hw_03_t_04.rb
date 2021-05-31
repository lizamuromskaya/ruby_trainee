# frozen_string_literal: true

def task4(data)
  character_counter = {}
  character_counter[:letters] = data.count('A-Za-z')
  character_counter[:digits] = data.count('0-9')
  character_counter
end
