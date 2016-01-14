require 'node_renderer'
require 'html_parser'

describe NodeRenderer do
  let(:tree){DOMReader.new}
  let(:html){"<p> some text <em> nested text </em> more text </p>"}
  let(:renderer) do
    tree.build_tree(html)
    NodeRenderer.new(tree)
  end

  describe "#node_count" do

    it "returns the total nodes in the subtree of the node" do
      
      expect(renderer.render(tree.root)).to match(/5 nodes/)

    end

  end

  describe "#type_count" do

    it "returns the total type of nodes in the subtree of the node" do
      hash = renderer.type_count(tree.root)
      expect(hash['em']).to eq 1
    end

  end

end