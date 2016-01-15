require_relative 'tag_parser'

class DOMReader

  attr_reader :root, :node_count

  def initialize
    @root = Tag.new("document")
    @root.depth = 0
    @node_count = 0
  end

  def build_tree(html)
    current_node = @root
    html.scan(/(<.+?>)|(?<=>)(.+?)(?=<)/) do |tag, text|
      next if tag =~ /<!doctype/
      if current_node.text && !inline_tag?(tag)
        current_node = current_node.parent
      end
      if opening_tag?(tag)
        tag_node = TagParser.parse_tag(tag, text)
        next unless tag_node
        current_node.children << tag_node
        @node_count += 1
        tag_node.depth = current_node.depth + 1
        tag_node.parent = current_node
        current_node = tag_node
      elsif closing_tag?(tag)
        current_node = current_node.parent
      end
    end
  end

  def inline_tag?(tag)
    tag =~ /<em/
  end

  def closing_tag?(tag)
    tag =~ /<\//
  end

  def opening_tag?(tag)
    !closing_tag?(tag)
  end
end
