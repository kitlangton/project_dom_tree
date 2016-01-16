require 'rainbow'

class NodeRenderer

  def render(node)
    output = []

    node_header(node, output)
    node_data(node, output)
    subtree_stats(node, output)

    output.join("\n")
  end

  private

  def node_count(node)
    node.children.size +
      node.children.inject(0) do |sum, child|
        sum += node_count(child)
      end
  end

  def node_header(node, output)
    output << "#{Rainbow(node.type.upcase).white} at depth #{Rainbow(node.depth).white} has #{Rainbow(node_count(node)).white} nodes in its subtree."
  end

  def subtree_stats(node, output)
    output << Rainbow("\nSubtree Stats:").white.underline
    type_count(node).each do |key, value|
      output << "#{key}: #{Rainbow(value).cyan}"
    end
  end

  def node_data(node, output)
    return unless node.parent || node.data_attributes.size > 0
    output << Rainbow("\nNode Data:").white.underline
    output << "parent: #{Rainbow(node.parent.type).cyan}" if node.parent
    node.data_attributes.each do |key, value|
      output << "#{key}: #{Rainbow(value).cyan}"
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
