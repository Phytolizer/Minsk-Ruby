# frozen_string_literal: true

require_relative "code_analysis/syntax/lexer"

def pretty_print(node, indent = "")
  print indent
  print node.kind

  print " #{node.value}" if node.instance_of?(SyntaxToken) && !node.value.nil?

  indent += "    "
  node.children.each do |child|
    pretty_print(child, indent)
  end
end

loop do
  print ">> "
  line = gets
  break if line.nil?

  parser = Parser.new(line)
  expression = parser.parse
  pretty_print(expression)
end
