# frozen_string_literal: true

class HashMap
  def initialize
    @load_factor = 0.75
    @capacity = 16
    @buckets = Array.new(@capacity)
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.to_s.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key, value)
    if has?(key) == true
      if @buckets[hash(key) % @capacity].instance_of?(LinkedList)
        @buckets[hash(key) % @capacity].update_node(key, value)
      else
        @buckets[hash(key) % @capacity][1] = value
      end
    else
      @capacity = @buckets.length
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
  end

  def capacity_check
    current_load = length / @buckets.length.to_f
    return unless current_load >= @load_factor

    @capacity *= 2
    current_entries = entries
    clear
    @buckets = Array.new(@capacity)
    current_entries.each { |key, value| set(key, value) }
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
    entries_array = entries
    keys = []
    entries_array.each { |node| keys << node[0] }
    keys
  end

  def values
    entries_array = entries
    values = []
    entries_array.each { |node| values << node[1] }
    values
  end

  def entries
    entries_array = []
    @buckets.each do |entry|
      if !entry.nil? && !entry.instance_of?(LinkedList)
        entries_array << entry
      elsif entry.instance_of?(LinkedList)
        list_array = @buckets[@buckets.index(entry)].list_to_array
        list_array.each { |node| @buckets << node }
      end
    end
    entries_array
  end
end
