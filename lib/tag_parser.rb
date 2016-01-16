require 'rainbow'

Rainbow.enabled = true


module TagParser

  def self.parse_text_tag(text)
    return nil if text.strip.empty?
    tag = Tag.new('text')
    tag.text = text.strip
    tag
  end

  def self.parse_tag(tag_string, text = nil)
    return parse_text_tag(text) if text

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
      disp pad(color(text))
    else
      disp pad(color("<#{type}#{display_attributes}>"))
    end
  end

  def display_attributes
    output = []
    data_attributes.each do |key, value|
      if key == :classes
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
    return if type == 'text'
    if li?
      puts (color("</#{type}>"))
    elsif em?
      disp color("</#{type}>")
    else
      disp pad(color("</#{type}>"))
    end
  end

  def inline?
    type == 'text' || type == "em" || type == "li" || type == 'strong' || type == 'span'
  end

  def em?
    type == 'em' || type == 'strong' || type == 'span'
  end

  def li?
    type == 'li'
  end

  def disp_inline?
    return false unless parent
    !children.empty? && inline? ||  parent.inline?
  end

  def pad_inline?
    return false unless parent
    return false if li?
    parent.inline? || higher_sibling_inline?
  end

  def disp(string)
    if disp_inline?
      print string
    else
      puts string
    end
  end

  def higher_sibling_inline?
    return false unless parent
    my_index = parent.children.index(self)
    return if my_index == 0
    inline? && parent.children[my_index-1].inline?
  end

  def pad(string)
    if parent && parent.li? || parent && parent.em?
      string
    elsif pad_inline?
      " " + string
    else
      "  " * depth + string
    end
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
