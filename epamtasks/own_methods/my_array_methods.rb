# frozen_string_literal: true

# This is my own methods each,map,select
module MyArrayMethods
  refine Array do

    def my_each
      if block_given?
        for i in 0..(self.size-1)
          yield(self[i])
        end
      end
    end

    def my_map
      arr = []
      if block_given?
        for i in 0..(self.size-1)
          arr << yield(self[i])
        end
      end
      arr
    end

    def my_select
      new_arr = []
      if block_given?
        for i in 0..(self.size-1)
          new_arr << self[i] if yield(self[i]) == true
        end
        new_arr.my_each { |element| p element }
      end
    end

  end
end
