require_relative 'dom_reader'

class Outputter

  def initialize(tree)
    @tree = tree
  end

  def output(node = @tree.root)
    return unless node

    node.display_open

    node.children.each do |child|
      output(child)
    end

    node.display_close
  end
end

html = File.read(__dir__ + "/../test.html")
html_string = "<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"
html = html.gsub("\n", " ")
parser = DOMReader.new
parser.build_tree(html)

outputter = Outputter.new(parser)
# Rainbow.enabled = false
# $stdout.reopen("out.txt", "w")
outputter.output
