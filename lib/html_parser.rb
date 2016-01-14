require_relative 'tag_parser'

class HTMLParser

  attr_reader :root

  def initialize
    @root = nil
  end

  def parse(html)
    current_node = nil
    html.scan(/(<.+?>)|(?<=>)(.+?)(?=<)/) do |tag, text|
      next if tag =~ /<!doctype/
      if tag
        if opening_tag?(tag)
          tag_node = TagParser.parse_tag(tag)
          unless @root
            tag_node.depth = 0
            @root = tag_node
          end
          if current_node
            current_node.children << tag_node
            tag_node.depth = current_node.depth + 1
            tag_node.parent = current_node
          end
          current_node = tag_node
        elsif closing_tag?(tag)
          current_node = current_node.parent
        end
      elsif text.strip.length > 0
        text_node = Tag.new('text')
        text_node.text = text.strip
        current_node.children << text_node
        text_node.depth = current_node.depth + 1
        text_node.parent = current_node
      end
    end
  end

  def output(node = @root)
    if node.text
      puts "  " * node.depth + node.display_open
    else
      puts "  " * node.depth + node.display_open
    end
    node.children.each do |child|
      output(child)
    end
    if node.type == "text"
    else
      puts "  " * node.depth + node.display_close
    end
  end

  def closing_tag?(tag)
    tag =~ /<\//
  end

  def opening_tag?(tag)
    !closing_tag?(tag)
  end
end

# html = File.read(__dir__ + "/../test.html")
# html_string = "<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"
# html = html.gsub("\n", " ")
# parser = HTMLParser.new
# parser.parse(html)
# parser.output
