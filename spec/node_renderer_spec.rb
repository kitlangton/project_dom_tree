require 'node_renderer'
require 'dom_reader'

describe NodeRenderer do
  let(:tree){DOMReader.new}
  let(:html){File.read(__dir__ + "/../small.html")}
  let(:renderer) do
    tree.build_tree(html)
    NodeRenderer.new(tree)
  end

  describe "#render" do

    it "returns the total nodes in the subtree of the node" do
      expect(renderer.render(tree.root)).to match(/13 nodes/)
    end

    it "returns the total type of nodes in the subtree of the node" do
      expect(renderer.render(tree.root)).to match(/em: 3/)
    end

    it "returns the data attributes of the node" do
      expect(renderer.render(tree.root.children[0])).to match(/id: cool-node/)
    end
  end

end
