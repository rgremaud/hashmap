require_relative 'lib/hashmap'

new_hash = HashMap.new

p new_hash.hash('Romain')

p new_hash.hash('Theo')

p new_hash.hash('Whitney')

p new_hash.print_load_factor
