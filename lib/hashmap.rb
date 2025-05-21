class HashMap
  def initialize
    @load_factor = 0.8 # Need to grow capacity when there are 16 * 0.8 = 12.8 entries
    @capacity = 16 # total number of buckets
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end
end
