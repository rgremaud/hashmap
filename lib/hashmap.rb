# frozen_string_literal: true

class HashMap
  def initialize
    @load_factor = 0.8 # Need to grow capacity when there are 16 * 0.8 = 12.8 entries
    @capacity = 16 # total number of buckets
    @buckets = Array.new(@capacity)
  end

  # raise IndexError if index.negative? || index >= @buckets.length
  # create an array @buckets
  # Put each entry inside a bucket as a Node item, which holds both the key and the value.
  # To retrieve the value, we hash the key and calculate its bucket number.
  # If the bucket is not empty, then we go to that bucket.
  # Now we compare if the node’s key is the same key that was used for the retrieval.
  # If it is, then we can return the node’s value. Otherwise, we return nil.
  # given any number modulo by 16 we will get a number between 0 and 15.

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key, value)
    @capacity = @buckets.length # find a betteer place for this?  Inserting in the capcity check was brekaing things
    capacity_check
    index = hash(key) % @capacity
    node = [key, value]
    if @buckets[index].nil?
      @buckets[index] = node
    else
      new_list = LinkedList.new
      new_list.append(@buckets[index])
      new_list.append(node)
      @buckets[index] = new_list
    end
  end

  def capacity_check
    current_load = @buckets.compact.count / @buckets.length.to_f
    return unless current_load >= @load_factor # checks if capacity needs to increase

    old_capacity = @capacity
    new_capacity = 2 * old_capacity
    (new_capacity - old_capacity).times do
      @buckets << nil
    end
  end

  def get(key)
    # takes one argument as a key and returns the value that is assigned to this key.
    # If key is not found, return nil.
  end

  def has?(key)
    # takes a key as an argument and returns true or false based on whether or not the key is in the hash map.
  end

  def remove(key)
    # takes a key as an argument. If the given key is in the hash map,
    # it should remove the entry with that key and return the deleted entry’s value.
    # If the key isn’t in the hash map, it should return nil.
  end

  def length
    # length returns the number of stored keys in the hash map.
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
    p "bucket length is #{@buckets.length}"
  end
end
