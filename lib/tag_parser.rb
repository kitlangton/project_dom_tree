require 'rainbow'

module TagParser
  def self.parse_tag(tag_string)
    type = tag_string.match /<(\w+)/
    type = type[1] if type

    tag = Tag.new(type)

    tag_string.scan /\s(\w+)\s*=\s*['|"](.+?)['|"]/ do |key, value|
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

  def display_open
    if type == 'text'
      puts pad(color(text))
    else
      puts pad(color("<#{type}#{display_attributes}>"))
    end
  end

  def inline?
    type == 'em' || type == 'text'
  end

  def display_attributes
    output = []
    data_attributes.each do |key, value|
      if key == 'classes'
        output << "class='#{display_classes}'"
      else
        output << "#{key}='#{value}'"
      end
    end
    " #{output.join(" ")}" unless output.empty?
  end

  def display_classes
    classes.join(" ")
  end

  def data_attributes
    {
      classes: classes,
      id: id,
      name: name,
      src: src,
      title: title,
      text: text
    }.reject { |key, value| value.nil? }
  end

  def display_close
    puts pad(color("</#{type}>")) unless type == "text"
  end

  def pad(string)
    "  " * depth + string
  end

  def matches?(attribute, value)
    if attribute == :class
      classes.include?(value) if classes
    else
      send(attribute) == value
    end
  end

  def color(text)
    if type == 'text'
      return Rainbow(text).white
    end

    case depth
    when 0
      Rainbow(text).red
    when 1
      Rainbow(text).red.bright
    when 2
      Rainbow(text).yellow
    when 3
      Rainbow(text).green
    when 4
      Rainbow(text).cyan
    when 5
      Rainbow(text).blue
    else
      Rainbow(text).blue
    end
  end
end
