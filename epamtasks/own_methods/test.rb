# frozen_string_literal: true

load 'my_array_methods.rb'
using MyArrayMethods
array = [1, 2, 3, 4, 5, 6]
array.my_each { |element| p element }
puts '========'
array.my_map { |element| p element + 2 }
puts '========'
array.my_select(&:even?)
puts '========'
array.my_select(&:integer?)
puts '========'
