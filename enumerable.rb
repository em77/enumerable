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
        boolean = false if !self
      end
    end
    boolean
  end

  def my_any?(&block)
    self.my_each do |element|
      if block_given?
        return true if block.call(element)
      else
        return true if self
      end
    end
    false
  end

  def my_none?(&block)
    boolean = true
    self.my_each do |element|
      if block_given?
        boolean = false if block.call(element)
      else
        boolean = false if self
      end
    end
    boolean
  end

  def my_count(arg = nil, &block)
    counter = 0
    if arg.nil? && !block_given?
      self.my_each do |element|
        counter += 1
      end
    elsif !arg.nil?
      puts "warning: given block not used"
      self.my_each do |element|
        counter += 1 if element == arg
      end
    else
      self.my_each do |element|
        counter += 1 if block.call(element)
      end
    end
    counter
  end

  def my_map(&block)
    return self.to_enum(:my_map) if !block_given?
    new_array = []
    counter = 0
    while counter < self.length
      new_array << block.call(self.to_a[counter])
      counter += 1
    end
    new_array
  end

  def my_inject(arg = nil, &block)
    memo = arg if arg
    self.my_each do |element|
      if memo
        memo = block.call(memo, element)
      else
        memo = element
      end
    end
    memo
  end
end