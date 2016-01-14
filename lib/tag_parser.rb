module TagParser
  def self.parse_tag(tag_string)
    type = tag_string.match /<(\w+)/
    type = type[1] if type

    tag = Tag.new(type)

    tag_string.scan /\s(\w+)\s*=\s*'(.+?)'/ do |key, value|
      case key
      when 'class'
        tag.classes = value.split(" ")
      else
        tag.send("#{key}=".to_sym, value)
      end
    end

    tag
  end
end

class Tag
  attr_accessor :type, :classes, :id, :name, :src, :title, :children, :parent, :text, :depth

  def initialize(type = nil)
    @type = type
    @children = []
  end
end
