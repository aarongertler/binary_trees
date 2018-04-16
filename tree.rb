# Write a method build_tree which takes an array of data (e.g. [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]) 

# Now refactor your build_tree to handle data that isn't presorted and cannot be easily sorted prior to building the tree. 
# You'll need to figure out how to add a node for each of the possible cases (e.g. if it's a leaf versus in the middle somewhere).

# Write a simple script that runs build_tree so you can test it out.

# Build a method breadth_first_search which takes a target value and returns the node at which it is located 
# using the breadth first search technique. 
# Tip: You will want to use an array acting as a queue to keep track of all the child nodes that you have yet to search 
# and to add new ones to the list (as you saw in the video). If the target node value is not located, return nil.

# Build a method depth_first_search which returns the node at which the target value is located using the depth first search technique. 
# Use an array acting as a stack to do this.

# Next, build a new method dfs_rec which runs a depth first search as before but this time, instead of using a stack, make this method recursive.


# Tips:
# You can think of the dfs_rec method as a little robot that crawls down the tree, 
# checking if a node is the correct node and spawning other little robots to keep 
# searching the tree. No robot is allowed to turn on, though, until all the robots 
# to its left have finished their task.
# The method will need to take in both the target value and the current node to compare against.


require_relative 'node.rb'

class Tree

  def initialize data
    @root_node = Node.new(data[0])
    build_tree(data[1..-1])
  end

  def build_tree data
    data.each do |n|
      place_node(n)
    end
  end

  def place_node value
    new_node = Node.new(value)
    current_node = @root_node # Start placement process at the root
    until current_node == nil do
      if value < current_node.value
        parent = current_node
        current_node = current_node.left_child # Keep sliding to the left until we hit a lower value than ours
      else
        parent = current_node
        current_node = current_node.right_child
      end
    end
    new_node.parent = parent
    if value < parent.value
      parent.left_child = new_node
    else
      parent.right_child = new_node
    end
  end

  def breadth_first_search value
    queue = []
    current_node = @root_node
    until current_node == nil # We run out of nodes to check
      if current_node.value == value
        return current_node.value
      end
      queue << current_node.left_child unless current_node.left_child == nil
      queue << current_node.right_child unless current_node.right_child == nil
      current_node = queue.shift() # We aren't at the right value yet, so let's check the left branch, then the right branch, then the left and right branches of the left branch...
    end
    nil # We never found our value
  end

  # Two options for depth_first: We can either add R-L to the right side of our queue and use pop() to grab next node,
  # or we can add to L-R to the left side of our queue and use pop(). Either way, we grab the child nodes of our current node, and then their child nodes,
  # etc., before we move on to the other side of the root. 

  def depth_first_search value
    queue = []
    current_node = @root_node
    until current_node == nil
      if current_node.value == value
        return current_node.value
      end
      queue << current_node.right_child unless current_node.right_child == nil
      queue << current_node.left_child unless current_node.left_child == nil
      current_node = queue.pop()
    end
    nil # We never found our value
  end

  # The below assumes a sorted tree, will return nil as soon as we run into the end of a branch where we know we've taken all the right paths so far
  # I could also build a version that does check every node, just in case, but since we're only building sorted trees...

  def dfs_rec value, node = @root_node # Recursive depth-first search, starting at the root
    if node == nil
      return nil
    elsif node.value == value
      return node.value
    elsif value < node.value # Node value too high, keep moving left
      dfs_rec(value, node.left_child)
    else # Node value too low, keep moving right
      dfs_rec(value, node.right_child)
    end
  end
end


