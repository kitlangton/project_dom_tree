require_relative 'tag_parser'

class DOMReader

  attr_reader :root, :node_count

  TAG_TEXT_REGEX = /(<.+?>)|(?<=>)(.+?)(?=<)/
  DOCTYPE_REGEX = /<!doctype/

  def build_tree(html)
    html = html.gsub("\n", "")
    set_up
    html.scan(TAG_TEXT_REGEX) do |tag, text|
      next if tag =~ DOCTYPE_REGEX
      pop_node if @current_node.text && !inline_tag?(tag)

      if opening_tag?(tag)
        next unless node = TagParser.parse_tag(tag, text)
        add_to_children(node)
        @current_node = node
      elsif closing_tag?(tag)
        pop_node
      end
    end
  end

  private

  def set_up
    @root = Tag.new("document")
    @root.depth = 0
    @node_count = 0
    @current_node = @root
  end

  def add_to_children(node)
    increment_node_count
    @current_node.children << node
    node.depth = current_depth + 1
    node.parent = @current_node
  end

  def increment_node_count
    @node_count += 1
  end

  def current_depth
    @current_node.depth
  end

  def pop_node
    @current_node = @current_node.parent
  end

  def inline_tag?(tag)
    tag =~ /<em>/ ||
    tag =~ /<strong>/ ||
    tag =~ /<span>/
  end

  def closing_tag?(tag)
    tag =~ /<\//
  end

  def opening_tag?(tag)
    !closing_tag?(tag)
  end
end
