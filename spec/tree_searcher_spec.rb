require 'dom_reader'
require 'tree_searcher'
require 'node_renderer'

describe  TreeSearcher  do
  let(:tree){DOMReader.new}
  let(:html){"<div> <em> <p id='type' class='jones putty'> some <div class='putty'> text </div> </p> </em> </div>"}
  let(:searcher) do
    tree.build_tree(html)
    TreeSearcher.new(tree)
  end

  let(:renderer) do
    tree.build_tree(html)
    NodeRenderer.new(tree)
  end

  describe '#search_by' do
    it 'returns all nodes that match the id provided' do
      nodes = searcher.search_by(:id, 'type')
      expect(nodes[0].type).to eq 'p'
    end

    it 'returns all nodes that match the class provided' do
      nodes = searcher.search_by(:class, 'putty')

      nodes.each { |node| puts renderer.render(node) }
      expect(nodes.size).to eq 2
    end
  end

end
