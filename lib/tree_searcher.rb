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
end
