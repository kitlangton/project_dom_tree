require 'tag_parser'

describe TagParser do
  describe '#parse_tag' do

    let(:tag) do
      tag_string = "<p class='foo bar' id='baz' name='fozzie'>"
      TagParser.parse_tag(tag_string)
    end

    let(:img_tag) do
      tag_string = "<img src='http://www.example.com' title='funny things'>"
      TagParser.parse_tag(tag_string)
    end

    it 'parses a tag into a tag object' do
      expect(tag).to be_a Tag
    end

    it 'contains the type' do
      expect(tag.type).to eq 'p'
    end

    it 'contains the classes' do
      expect(tag.classes).to eq ['foo', 'bar']
    end

    it 'contains the id' do
      expect(tag.id).to eq 'baz'
    end

    it 'contains the name' do
      expect(tag.name).to eq 'fozzie'
    end

    it 'contains the src' do
      expect(img_tag.src).to eq 'http://www.example.com'
    end

    it 'contains the title' do
      expect(img_tag.title).to eq 'funny things'
    end

    it 'parses tags with spaces' do
      space_tag_string = "<div id = 'bim'>"
      tag = TagParser.parse_tag(space_tag_string)
      expect(tag.id).to eq 'bim'
    end
  end
end
