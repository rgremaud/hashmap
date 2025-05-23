# frozen_string_literal: true

class HashMap
  def initialize
    @load_factor = 0.8
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
    # takes a key as an argument. If the given key is in the hash map,
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
    # length returns the number of stored keys in the hash map.
    length = 0
    @buckets.each do |node|
      length += 1 if node != nil # rubocop:disable Style/NonNilCheck
    end
    length
  end

  def clear
    # clear removes all entries in the hash map.
  end

  def keys
    # keys returns an array containing all the keys inside the hash map.
  end

  def values
    # values returns an array containing all the values.
  end

  def entries
    # entries returns an array that contains each key, value pair. Example:
    # [[first_key, first_value], [second_key, second_value]]
  end

  def print_hash
    p @buckets
  end
end
