# frozen_string_literal: true

require_relative "syntax_node"

# A single element of the Minsk language.
class SyntaxToken < SyntaxNode
  def initialize(kind, position, text, value)
    super
    @kind = kind
    @position = position
    @text = text
    @value = value
  end

  attr_reader :kind, :position, :text, :value

  def children
    []
  end
end
