require 'dom_reader'
require 'tree_searcher'

describe  TreeSearcher  do
  let(:tree){DOMReader.new}
  let(:html){""}
  let(:searcher) do
    tree.build_tree(html)
    TreeSearcher.new(tree)
  end

  describe '#search_by' do
    it 'returns all nodes that match the class provided' do

    end
  end

end
