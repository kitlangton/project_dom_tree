require 'dom_reader'

describe DOMReader do

  let(:html_string) {"<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"}
  let(:parser) { DOMReader.new }

  describe '#build_tree' do
    it 'document is the root node' do
      parser.build_tree(html_string)

      expect(parser.root.type).to eq 'document'
    end

    it 'handles simple tags' do
      html = "<p> hi </p>"
      parser.build_tree(html)
      p_tag = parser.root.children.first

      expect(p_tag.type).to eq 'p'
    end

    it 'handles tags with attributes' do
      html = "<p id='valid'> hi </p>"
      parser.build_tree(html)
      p_tag = parser.root.children.first

      expect(p_tag.id).to eq 'valid'
    end

    it 'handles text' do
      html = "<p> text <em> nice </em> good </p>"
      parser.build_tree(html)
      p_tag = parser.root.children.first
      em_tag = p_tag.children[1]
      inner_text = em_tag.children.first

      expect(inner_text.text).to eq 'nice'
    end

    it 'assigns depth' do
      html = "<p> hi </p>"
      parser.build_tree(html)
      p_tag = parser.root.children.first

      expect(p_tag.depth).to eq 1
    end

    it 'has the correct number of nodes' do
      parser.build_tree(html_string)

      expect(parser.node_count).to eq 7
    end
  end
end
