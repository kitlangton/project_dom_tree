class NodeRenderer

  def initialize(tree = nil)

    @tree = tree

  end


  def render(node)

    "this node has #{node_count(node)} nodes"

  end

  def node_count(node)

    node.children.size + 
      node.children.inject(0) do |sum, child|
        sum += node_count(child)
      end

  end

  def type_count(node)
    type_hash = {}
    
  end

end