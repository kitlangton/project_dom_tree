require 'html_parser'

describe HTMLParser do

  let(:html_string) {"<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"}
  let(:parser) { HTMLParser.new }

  describe '#parse' do
    it 'sets the first tag to the root node' do
      parser.parse(html_string)

      expect(parser.root.type).to eq 'div'
    end

    it 'sets the first tag to the root node' do
      parser.parse(html_string)

      expect(parser.root.children[1].type).to eq 'div'
    end
  end
end
