class NodeRenderer

  def initialize(tree = nil)

    @tree = tree

  end

  def render(node)
    output = []

    output << "#{node.type.upcase} at depth #{node.depth} has #{node_count(node)} nodes."

    output << "Node Data:"

    node.data_attributes.each do |key, value|
      output << "#{key}: #{value}"
    end

    output << "Subtree Stats:"

    type_count(node).each do |key, value|
      output << "#{key}: #{value}"
    end

    output.join("\n")
  end

  def node_count(node)
    node.children.size +
      node.children.inject(0) do |sum, child|
        sum += node_count(child)
      end
  end

  def type_count(node)
    type_hash = Hash.new(0)
    stack = []
    stack << node
    while node = stack.pop
      node.children.each do |child|
        type_hash[child.type] += 1
        stack << child
      end
    end
    type_hash
  end

end
