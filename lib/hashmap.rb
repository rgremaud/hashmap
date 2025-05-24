# frozen_string_literal: true

class HashMap
  def initialize
    @load_factor = 0.75
    @capacity = 16
    @buckets = Array.new(@capacity)
  end

  # raise IndexError if index.negative? || index >= @buckets.length

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key, value)
    @capacity = @buckets.length # find a betteer place for this?
    capacity_check
    index = hash(key) % @capacity
    if @buckets[index].nil?
      @buckets[index] = [key, value]
    elsif @buckets[index].instance_of?(LinkedList)
      @buckets[index].prepend(key, value)
    else
      new_list = LinkedList.new
      new_list.prepend(@buckets[index][0], @buckets[index][1])
      new_list.prepend(key, value)
      @buckets[index] = new_list
    end
  end

  def capacity_check
    current_load = @buckets.compact.count / @buckets.length.to_f
    return unless current_load >= @load_factor

    old_capacity = @capacity
    new_capacity = 2 * old_capacity
    (new_capacity - old_capacity).times do
      @buckets << nil
    end
  end

  def get(key)
    return nil if @buckets[hash(key) % @capacity].nil?

    if @buckets[hash(key) % @capacity].instance_of?(LinkedList)
      @buckets[hash(key) % @capacity].find_value(key)
    else
      @buckets[hash(key) % @capacity][1]
    end
  end

  def has?(key)
    if @buckets[hash(key) % @capacity].instance_of?(LinkedList)
      @buckets[hash(key) % @capacity].contains_key?(key)
    elsif @buckets[hash(key) % @capacity].nil?
      false
    elsif @buckets[hash(key) % @capacity][0] == key
      true
    end
  end

  def remove(key)
    if @buckets[hash(key) % @capacity].instance_of?(LinkedList)
      @buckets[hash(key) % @capacity].remove_node(key)
    elsif @buckets[hash(key) % @capacity][0] == key
      del_value = @buckets[hash(key) % @capacity][1]
      @buckets[hash(key) % @capacity] = nil
      puts "Deleted entry's value is #{del_value}"
    elsif @buckets[hash(key) % @capacity][0].nil?
      nil
    end
  end

  def length
    length = 0
    @buckets.each do |node|
      if node.instance_of?(LinkedList)
        length += node.size
      elsif !node.nil?
        length += 1
      end
    end
    length
  end

  def clear
    @buckets = []
    @capacity.times do
      @buckets << nil
    end
  end

  def keys
    keys_array = []
    @buckets.each do |key, _value| # rubocop:disable Style/HashEachMethods
      keys_array << key if !key.nil? && !key.instance_of?(LinkedList)
      keys_array << @buckets[@buckets.index(key)].list_keys if key.instance_of?(LinkedList)
    end

    keys_array.flatten
  end

  def values
    values_array = []
    @buckets.each do |key, value|
      values_array << value if !value.nil? && !value.instance_of?(LinkedList)
      values_array << @buckets[@buckets.index(key)].list_values if key.instance_of?(LinkedList)
    end

    values_array.flatten
  end

  def entries
    entries_array = []
    @buckets.each do |entry|
      entries_array << entry if !entry.nil? && !entry.instance_of?(LinkedList)
      entries_array << @buckets[@buckets.index(entry)].list_to_array if entry.instance_of?(LinkedList)
    end
    entries_array
  end
end
