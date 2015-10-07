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

  def my_select(&block)
    new_hash = {}
    new_array = []
    self.my_each do |element|
      if block.call(element)
        new_array.push(element) if self.class == Array
        new_hash[self.key(element)] = element if self.class == Hash
      end
    end
    return new_array if self.class == Array
    return new_hash if self.class == Hash
  end
end