require 'tag_parser'

class HTMLParser

  attr_reader :root

  def initialize
    @root = nil
  end

  def parse(html)
    current_node = nil
    puts "Parsing HTML:"
    html.scan(/(<.+?>)|(?<=>)(.+?)(?=<)/) do |tag, text|
      if tag
        puts "Current node is: #{current_node.type}" if current_node
        if opening_tag?(tag)
          puts "Found opening tag: #{tag}"
          tag_node = TagParser.parse_tag(tag)
          @root = tag_node unless @root
          if current_node
            puts "Adding #{tag} as child of #{current_node.type}" if current_node
            current_node.children << tag_node
            tag_node.parent = current_node
          end
          current_node = tag_node
        elsif closing_tag?(tag)
          current_node = current_node.parent
          puts "Found closing tag: #{tag}"
          puts "Jumping up to parent"
        end
      elsif text.strip.length > 0
        # puts "text: #{text.strip}"
      end
    end
  end

  def closing_tag?(tag)
    tag =~ /<\//
  end

  def opening_tag?(tag)
    !closing_tag?(tag)
  end
end
