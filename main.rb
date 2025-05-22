require_relative 'lib/hashmap'
require_relative 'lib/linkedlists'
require_relative 'lib/node'

new_hash = HashMap.new

p new_hash.set_key('Romain', '37 year old, male') # whitney and romain create a collision
p new_hash.set_key('Whitney', '37 year old, female')
p new_hash.set_key('Theo', '2 year old, male')

p new_hash.print_hash
