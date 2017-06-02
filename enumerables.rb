class Array

  def my_each
    i = 0
    while i < self.length
      yield(self[i])
      i += 1
    end
  end

  def my_select
    new_array = []
    self.my_each do |el|
      new_array << el if yield(el)
    end
    new_array
  end

  def my_reject
    new_array = []
    self.my_each do |el|
      new_array << el if !yield(el)
    end
    new_array
  end

  def my_any?
    my_each do |el|
      return true if yield(el)
    end
    false
  end

  def my_all?
    my_each do |el|
      return false if !yield(el)
    end
    true
  end

  def my_flatten
    new_array = []
    my_each do |el|
      if el.is_a?(Array)
        new_array += el.my_flatten
      else
        new_array << el
      end
    end
    new_array
  end

  def my_zip(a,b)
    new_array = []
    (0..self.length-1).to_a.my_each do |idx|
      new_array << [self[idx],a[idx],b[idx]]
    end
    new_array
  end

  def my_rotate(rotate = 1)
    if rotate > 0
      rotate.times do
        shifted_el = self.shift
        self << shifted_el
      end
    else
      rotate.abs.times do
        popped_el = self.pop
        self.unshift(popped_el)
      end
    end
    self
  end

  def my_join(delimiter = "")
    new_str = ""
    my_each do |el|
      new_str += el
      new_str += delimiter
    end
    !delimiter.nil? ? new_str[0...-1] : new_str
  end

  def my_reverse
    reverse_array = []
    my_each do |el|
      reverse_array.unshift(el)
    end
    reverse_array
  end

end
