class TreeSearcher

  attr_reader :tree

  def initialize(tree)
    @tree = tree
  end

  def search_by(attribute, value, node = @tree.root)
    node.children.map do |child|
      if child.matches?(attribute, value)
        [child, search_by(attribute, value, child)]
      else
        search_by(attribute, value, child)
      end
    end.flatten.compact
  end

  def search_children(node, attribute, value)
    search_by(attribute, value, node)
  end

  def search_ancestors(node, attribute, value, array = [])
    return array unless node.parent

    array << node.parent if node.parent.matches?(attribute, value)

    search_ancestors(node.parent, attribute, value, array)
  end
end
