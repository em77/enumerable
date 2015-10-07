module Enumerable
  def my_each(&block)
    counter = 0
    while counter < self.length
      block.call(self[counter])
      counter += 1
    end
    self
  end

  def my_each_with_index(&block)
    counter = 0
    while counter < self.length
      block.call(self[counter], counter)
      counter += 1
    end
    self
  end
end