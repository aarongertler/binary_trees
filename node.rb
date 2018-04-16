class Node

  attr_accessor :parent
  attr_accessor :left_child
  attr_accessor :right_child
  attr_accessor :value

  def initialize value, parent = nil, left_child = nil, right_child = nil
    @value = value
    @parent = parent
    @left_child = left_child
    @right_child = right_child
  end
end

