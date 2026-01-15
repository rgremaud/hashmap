# frozen_string_literal: true

class LinkedList
  attr_accessor :name

  def initialize
    @head = nil
    @tail = nil
  end

  def append(key, value)
    if @head.nil?
      @tail = Node.new
      @tail.key = key
      @tail.value = value
      @head = @tail
    else
      temp_node = Node.new
      temp_node.key = key
      temp_node.value = value
      temp_node.next_node = nil
      @tail.next_node = temp_node
      @tail = temp_node
    end
  end

  def prepend(key, value)
    if @head.nil?
      @head = Node.new
      @head.key = key
      @head.value = value
      @tail = @head
    else
      temp_node = Node.new
      temp_node.key = key
      temp_node.value = value
      temp_node.next_node = @head
      @head = temp_node
    end
  end

  def size
    size = 0
    if @head.nil?
      "Current size is #{size}."
    elsif !@head.nil? && @head.next_node.nil?
      size += 1
      "Current size is #{size}."
    else
      size = 1
      current_node = @head
      loop do
        size += 1
        current_node = current_node.next_node
        break if current_node.next_node.nil?
      end
      size
    end
  end

  def head
    @head.value
  end

  def next_node
    @head.next_node
  end

  def tail
    @tail.value
  end

  def contains_key?(key)
    current_node = @head
    value_check = nil
    return true if current_node.key == key

    while current_node.next_node != nil # rubocop:disable Style/NonNilCheck
      current_node = current_node.next_node
      return true if current_node.key == key

      value_check = false

    end
    value_check
  end

  def find_value(key)
    current_node = @head
    return current_node.value if current_node.key == key

    until current_node.next_node.nil?
      current_node = current_node.next_node
      return current_node.value if current_node.key == key
    end

    nil if current_node.next_node.nil?
  end

  def to_s
    string = ''
    current_node = @head
    until current_node.nil?
      string += "( #{current_node.key}, #{current_node.value} ) -> "
      current_node = current_node.next_node
    end
    string += 'nil'
    string
  end

  def remove_node(key)
    current_node = @head
    del_value = ''
    if current_node.key == key
      del_value = current_node.value
      @head = current_node.next_node
    else
      del_value = current_node.next_node.value
      while (current_node.next_node != nil) && (current_node.next_node.key != key) # rubocop:disable Style/NonNilCheck
        if (current_node.next_node == nil) || (current_node.next_node.key == key) # rubocop:disable Style/NilComparison
          current_node.next_node = current_node.next_node.next_node
        else
          current_node = current_node.next_node
        end
      end
      current_node.next_node = current_node.next_node.next_node
    end
    puts "Deleted entry's value was #{del_value}"
  end

  def list_to_array
    current_node = @head
    entries_array = []
    until current_node.nil?
      entries_array << [current_node.key, current_node.value]
      current_node = current_node.next_node
    end
    entries_array
  end

  def update_node(key, value)
    current_node = @head
    until current_node.nil?
      current_node.value = value if current_node.key == key
      current_node = current_node.next_node
    end
  end
end
