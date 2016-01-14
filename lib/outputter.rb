require_relative 'html_parser'

class Outputter

  def initialize(tree)
    @tree = tree
  end

  def output(node = @tree.root)
    return unless node

    puts "  " * node.depth + node.display_open

    node.children.each do |child|
      output(child)
    end

    puts "  " * node.depth + node.display_close
  end
end

html = File.read(__dir__ + "/../test.html")
html_string = "<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"
html = html.gsub("\n", " ")
parser = HTMLParser.new
parser.parse(html)

outputter = Outputter.new(parser)
outputter.output
