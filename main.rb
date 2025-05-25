require_relative 'lib/hashmap'
require_relative 'lib/linkedlists'
require_relative 'lib/node'

test = HashMap.new

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')
test.set('moon', 'silver')

p test.entries
p test.length

# need to update set so if same key is entered twice, it replaces the existing keys value
# ex: set('grape', 'purple') then set('grape', 'green') will overwrite existing key
#
