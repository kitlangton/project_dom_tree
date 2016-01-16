require 'highline'
require_relative 'dom_reader'
require_relative 'node_renderer'
require_relative 'outputter'
require_relative 'tree_searcher'

class CLIQuery

  attr_reader :cli

  def initialize
    @tree = nil
    @cli = HighLine.new
  end


  def build_tree(html)
    @tree = DOMReader.new
    @tree.build_tree(html)
  end

  def start(html)
    build_tree(html)
    ask_options
  end

  def ask_options
    cli.choose do |menu|
      menu.prompt = "How would you like to operate on the HTML?"
      menu.choice(:search) { ask_search }
      menu.choices(:output) { display_output }
    end
  end

  def display_output
    Outputter.new(@tree).output
  end

end

file = File.read(ARGV[0])
CLIQuery.new.start(file)
