module Enumerable
  def my_each(&block)
    return self.to_enum(:my_each) if !block_given?
    counter = 0
    while counter < self.length
      block.call(self[counter])
      counter += 1
    end
    self
  end

  def my_each_with_index(&block)
    return self.to_enum(:my_each_with_index) if !block_given?
    counter = 0
    while counter < self.length
      block.call(self[counter], counter)
      counter += 1
    end
    self
  end

  def my_select(&block)
    return self.to_enum(:my_select) if !block_given?
    new_array = []
    new_hash = {}
    self.my_each do |element|
      if self.class == Array
        new_array.push(element) if block.call(element)
      elsif self.class == Hash
        new_hash[self.key(element)] = element if 
          block.call(self.key(element), element)
      end
    end
    return new_array if self.class == Array
    return new_hash if self.class == Hash
  end

  def my_all?(&block)
    boolean = true
    self.my_each do |element|
      if block_given?
        boolean = false if !block.call(element)
      else
        boolean = true if !self
      end
    end
    boolean
  end
end