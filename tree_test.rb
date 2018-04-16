require_relative 'tree.rb'
require_relative 'node.rb'

data = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

tree = Tree.new(data)

puts tree.breadth_first_search(6345)
puts tree.breadth_first_search(3)

puts tree.depth_first_search(6345)
puts tree.depth_first_search(3)

puts tree.dfs_rec(6345)