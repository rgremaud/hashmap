require_relative 'lib/hashmap'
require_relative 'lib/linkedlists'
require_relative 'lib/node'

test = HashMap.new

# Look at re-writing the node function w/seperate key and value data points?

test.set('apple', 'red')
# test.set('banana', 'yellow')
# test.set('carrot', 'orange')
# test.set('dog', 'brown')
# test.set('elephant', 'gray')
# test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
# test.set('ice cream', 'white')
# test.set('jacket', 'blue')
# test.set('kite', 'pink')
# test.set('lion', 'golden')

# p test.print_hash
p test.has?('grape')
# p test.has?('hat')
# p test.has?('apple')
